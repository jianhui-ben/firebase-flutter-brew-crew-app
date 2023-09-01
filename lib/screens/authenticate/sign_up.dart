import 'package:flutter/material.dart';
import 'package:firebase_flutter_brew_crew_app/services/auth.dart';

import '../../models/user.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';


class SignUp extends StatefulWidget {
  final Function toggleView;

  const SignUp({super.key, required this.toggleView});

  @override
  State<SignUp> createState() => _signUpState();
}

class _signUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String emailErrorText = "The email can't be empty";
  final String passwordErrorText =
      'The password has to be longer than 5 characters';
  String _errorText = '';
  bool loading = false;

  Future<void> signUpWithEmailAndPassword() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
    if (result is! BrewUser?) {
      setState(() {
        _errorText = result;
      });
    } else {
      _errorText = '';
      print("user signed up and logged in successfully");
      print("email: $email, password: $password, userId: $result");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool showEmailAndPasswordError = false;

    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text("Sign up for the brew crew"),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
              key: _formKey,
              child: ListView(children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Brew Crew',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emailErrorText;
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Email',
                      errorText:
                          showEmailAndPasswordError ? passwordErrorText : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 5) {
                        return passwordErrorText;
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Password',
                      errorText:
                          showEmailAndPasswordError ? passwordErrorText : null,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Sign up'),
                      onPressed: () async {
                        setState(() {
                          showEmailAndPasswordError =
                              true; // Set the flag to show the error text
                        });

                        if (_formKey.currentState!.validate()) {
                          setState(() {loading = true;});
                          await signUpWithEmailAndPassword();
                          if (!mounted) return;
                          setState(() {loading = false;});
                        }
                      },
                    )),
                if (_errorText.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      _errorText,
                      style: const TextStyle(
                          color: Colors.red), // Customize the error text style
                    ),
                  ),
              ]),
            )));
  }
}
