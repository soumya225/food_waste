import 'package:flutter/material.dart';
import 'package:food_waste/services/auth_service.dart';
import 'package:food_waste/services/connectivity_service.dart';
import 'package:food_waste/widgets/network_detection_wrapper.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _reenteredPasswordController = TextEditingController();

  Widget _buildImage(BuildContext context) {
    return Container(
      height: 128,
      padding: const EdgeInsets.all(16.0),
      child: Image.asset("assets/images/cooking.png",
        fit: BoxFit.contain
      ),
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
        validator: (String? val) {
          if (val == null || val.isEmpty)
            return "Email address should not be empty";
          else if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
              .hasMatch(val)) {
            return "Invalid email address";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            border: OutlineInputBorder()),
        validator: (String? val) {
          if (val != null && val.length < 6) {
            return "Password should be at least 6 characters";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _reenteredPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            labelText: "Confirm password",
            hintText: "Re-enter your password",
            border: OutlineInputBorder()),
        validator: (String? val) {
          if (val != _passwordController.text) {
            return "Passwords do not match";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          if (_key.currentState!.validate()) {
            bool emailsExists =
                await AuthService().emailAlreadyExists(_emailController.text);
            if (emailsExists) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Email already taken.")));
              return;
            }
            bool isRegistrationSuccessful = await AuthService().registerAccount(
                _emailController.text, _passwordController.text);

            if (isRegistrationSuccessful) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Registration successful! Please log in")));
              Navigator.pushReplacementNamed(context, "/login");
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Error registering. Please try again")));
            }
          }
        },
        child: Text(
          "Register",
          style: Theme.of(context).textTheme.button,
        ));
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account?",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          TextButton(
              onPressed: () =>
                  {Navigator.pushReplacementNamed(context, "/login")},
              child: Text(
                "Login",
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
        title: Text("Register"),
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
                    _buildConfirmPasswordTextField(context),
                    _buildRegisterButton(context),
                    _buildLoginButton(context)
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
