import 'package:flutter/material.dart';
import 'package:food_waste/screens/inventory_screen.dart';
import 'package:food_waste/screens/register_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  
  Widget _buildImage(BuildContext context) {
    return Container(
      height: 136,
      width: 136,
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        "assets/images/healthy_options.png",
        width: 136,
        fit: BoxFit.contain
      ),
    );
  }
  
  Widget _buildEmailTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "Enter your email",
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Enter your password",
          border: OutlineInputBorder()
        ),
      ),
    );
  }
  
  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
          Navigator.pushReplacementNamed(context, "/home")
        },
        child: Text(
          "Login",
          style: Theme.of(context).textTheme.button,
        )
    );
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
            onPressed: () => {
              Navigator.pushReplacementNamed(context, "/register")
            },
            child: Text(
              "Register",
              style: Theme.of(context).textTheme.button!.copyWith(color: Theme.of(context).colorScheme.secondary),
            )
          )
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
        child: Center(
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
    );
  }
}
