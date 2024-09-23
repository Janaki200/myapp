//import 'dart:math';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/data/constants/app_colors.dart';
import 'package:myapp/data/constants/logo.dart';
import 'package:myapp/loading_screen.dart';
import 'package:myapp/widgets/auth.textfield.dart';

class MyloginPage extends StatefulWidget {
  final void Function() togglePages;
  MyloginPage({super.key, required this.togglePages});

  @override
  State<MyloginPage> createState() => _MyloginPageState();
}

class _MyloginPageState extends State<MyloginPage> {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1808149181.
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void login() async{
    try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoadingScreen()), (route) => false);
} on FirebaseAuthException catch (e) {
  Fluttertoast.showToast(
                                  msg: e.message!,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
  // TODO
}
   //TODO
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.surfaceColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              //child: MyHomePage(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Text("Login",
                      style: TextStyle(
                        fontSize: 30,
                      )),
                  TextLogo(
                    text: '',
                    color: AppColors.primaryColor,
                    fontSize: 50,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AuthTextfield(
                    hintText: 'Enter the email',
                    controller: emailController,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthTextfield(
                    hintText: 'Enter the Password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  // Suggested code may be subject to a license. Learn more: ~LicenseLog:2877098626.
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                            if(EmailValidator.validate(emailController.text)){
                              login();
                            }else{
                              Fluttertoast.showToast(
                                  msg: "Enter a valid Email",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              //display alert message for invalid email
                            }
                          }else{
                            Fluttertoast.showToast(
                                msg:
                                    "Invalid Email or Password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                    },
                      
                    
                    color: AppColors.primaryColor,
                    child: const Text("Login"),
                    height: 48,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Row(
                    // Suggested code may be subject to a license. Learn more: ~LicenseLog:2141172840.
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: widget.togglePages, child: const Text("Register"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
