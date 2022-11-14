import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hiking_app/Classes/Utils.dart';
import 'package:hiking_app/Services/auth.dart';
import 'package:hiking_app/main.dart';


class SignUpPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUpPage({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);


  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthService _auth =AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Hiking App',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 86, 23),
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Create an account!',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    autovalidateMode:  AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email!'
                        : null,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter a min of 6 characters!'
                        : null,
                  ),
                ),

                //Spacing
                SizedBox(height:43),

                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 86, 23),
                      ),
                      child: const Text('Sign Up'),
                      onPressed: () async {
                        //Sign in with email and password
                        signUp();
                      },
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    RichText(text: TextSpan(
                        text: "Already have an account?   ",
                        style:  TextStyle(color: Colors.black,),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: 'Sign In',
                            style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 86, 23)),
                          )
                        ]
                    ))
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator(color: Color(0xFF1B5E20),)),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch(e) {
      print(e);
      Utils.showSnackBar(e.message);
    }

    //Gets rid of the progress indicator once we are done.
    navigatorKey.currentState!.popUntil((route) => route.isFirst);

  }
}