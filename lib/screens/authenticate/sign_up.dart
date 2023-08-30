import 'package:flutter/material.dart';
import 'package:firebase_flutter_brew_crew_app/services/auth.dart';


class SignUp extends StatefulWidget {

  final Function toggleView;
  const SignUp({super.key, required this.toggleView});

  @override
  State<SignUp> createState() => _signUpState();
}

class _signUpState extends State<SignUp> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String emailErrorText = "The email can't be empty";
  final String passwordErrorText = 'The password has to be longer than 5 characters';

  void _submitForm() {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      // Perform sign-up logic here
      print('Sign-up successful');
      print(emailController.text);
      print(passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {

    bool _showEmailAndPasswordError = false;

    return Scaffold(
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      errorText: _showEmailAndPasswordError ? emailErrorText : null,
                      errorStyle: const TextStyle(fontSize: 10),
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      errorText: _showEmailAndPasswordError ? passwordErrorText : null,
                      errorStyle: const TextStyle(fontSize: 10), // Adjust the font size
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Sign up'),
                      onPressed: () {
                        setState(() {
                          _showEmailAndPasswordError = true; // Set the flag to show the error text
                        });

                        if (_formKey.currentState!.validate()) {
                          // Form is valid, perform actions here
                          _submitForm();
                          widget.toggleView();
                        }

                      },
                    )),
              ]),
            )));
  }
}
