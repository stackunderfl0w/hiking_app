import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hiking_app/Classes/Utils.dart';

import '../../main.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Reset Password'),
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Recieve an email to\nreset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24, color: Color.fromARGB(255, 0, 86, 23)),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    cursorColor: Color.fromARGB(255, 0, 86, 23),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Color.fromARGB(255, 0, 86, 23))),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email!'
                        : null,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Color.fromARGB(255, 0, 86, 23),
                    ),
                    icon: Icon(Icons.email_outlined),
                    label: Text(
                      'Reset Password',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: resetPassword,
                  )
                ],
              ),
            ),
          )
      );

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator(color: Color(0xFF1B5E20),)),
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar('Password Reset Email Sent');
      //Gets rid of the progress indicator once we are done.
      navigatorKey.currentState!.popUntil((route) => route.isFirst);

    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }

}
