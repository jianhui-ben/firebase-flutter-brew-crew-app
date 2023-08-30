import 'package:firebase_flutter_brew_crew_app/screens/authenticate/sign_up.dart';
import 'package:firebase_flutter_brew_crew_app/services/auth.dart';
import 'package:flutter/material.dart';

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

  void _submitForm() {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      // Perform sign-in logic here
      print('Sign-in successful');
      print(emailController.text);
      print(passwordController.text);
    }
  }

  Future<void> _submitSignAnonForm() async {

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
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Sign in to the brew crew"),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
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
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
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
                    onPressed: () {
                      _submitForm();
                    },
                  )),
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
                          widget.toggleView();
                          // Navigator.pushNamed(context, SignUp());
                          //signup screen
                        },
                      ),
                    ],
                  ),
                  Text("or"),
                  ElevatedButton(
                    child: Text("Sign in anon"),
                    onPressed: () async {
                      await _submitSignAnonForm();
                    },
                  ),
                ],
              ),
            ])));
  }
}
