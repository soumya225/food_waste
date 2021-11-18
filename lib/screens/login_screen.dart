import 'package:flutter/material.dart';
import 'package:food_waste/services/auth_service.dart';
import 'package:food_waste/services/connectivity_service.dart';
import 'package:food_waste/widgets/network_detection_wrapper.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Widget _buildImage(BuildContext context) {
    return Container(
      height: 136,
      width: 136,
      padding: const EdgeInsets.all(8.0),
      child: Image.asset("assets/images/healthy_options.png",
          width: 136, fit: BoxFit.contain),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        obscureText: true,
        controller: _passwordController,
        decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          bool isLoginSuccessful = await AuthService()
              .signInWithEmailAndPassword(
                  _emailController.text, _passwordController.text);

          isLoginSuccessful
              ? Navigator.pushReplacementNamed(context, "/home")
              : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Error logging in. Please try again")));
        },
        child: Text(
          "Log in",
          style: Theme.of(context).textTheme.button,
        ));
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          TextButton(
              onPressed: () async {
                Navigator.pushReplacementNamed(context, "/register");
              },
              child: Text(
                "Register",
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
        child: Consumer<ConnectivityService>(
          builder: (context, service, widget) => NetworkDetection(
            child: Center(
              child: Form(
                key: _key,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  children: [
                    _buildImage(context),
                    _buildEmailTextField(context),
                    _buildPasswordTextField(context),
                    _buildLoginButton(context),
                    _buildRegisterButton(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
