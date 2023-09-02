import 'package:firebase_flutter_brew_crew_app/screens/authenticate/sign_up.dart';
import 'package:firebase_flutter_brew_crew_app/services/auth.dart';
import 'package:firebase_flutter_brew_crew_app/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String emailErrorText = "The email can't be empty";
  final String passwordErrorText = 'The password has to be longer than 5 characters';
  String _errorText = '';
  bool loading = false;

  Future<void> signInWithEmailAndPassword() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
    if (result is! BrewUser?) {
      setState(() {
        _errorText = result;
      });
    } else {
      _errorText = '';
      print("user signed in successfully");
      print("email: $email, password: $password, userId: $result");
    }
  }

  Future<void> signInAnonymously() async {

    dynamic result = await _auth.signInAnon();
    if (result == null) {
      print("error signing in anonymously");
    } else {
      print("user signed in");
      print(result);
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
          title: Text("Sign in to the brew crew"),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
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
                      'Sign in',
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
                      hintText: "Email / Phone number",
                      labelText: 'User Name',
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
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 5) {
                          return passwordErrorText;
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Password',
                        errorText: showEmailAndPasswordError
                            ? passwordErrorText
                            : null,
                      )),
                ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text(
                    'Forgot Password',
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () async {
                        setState(() {
                          showEmailAndPasswordError =
                              true; // Set the flag to show the error text
                        });

                        if (_formKey.currentState!.validate()) {
                          setState(() {loading = true;});
                          await signInWithEmailAndPassword();
                          setState(() {loading = false;});
                        }
                      },
                    )),
                if (_errorText.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      _errorText,
                      style: TextStyle(
                          color: Colors.red), // Customize the error text style
                    ),
                  ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Does not have account?'),
                        TextButton(
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 12),
                          ),
                          onPressed: () {
                            // go to the sign up screen
                            widget.toggleView();
                          },
                        ),
                      ],
                    ),
                    Text("or"),
                    ElevatedButton(
                      child: Text("Sign in anon"),
                      onPressed: () async {
                        setState(() {loading = true;});
                        await signInAnonymously();
                        if (!mounted) return;
                        setState(() {loading = false;});
                      },
                    ),
                  ],
                ),
              ]),
            )));
  }
}
