import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:myapp/data/constants/app_colors.dart';
import 'package:myapp/data/constants/logo.dart';
import 'package:myapp/loading_screen.dart';
import 'package:myapp/widgets/app_loader.dart';
//import 'package:myapp/home.dart';
import 'package:myapp/widgets/auth.textfield.dart';

class Register extends StatefulWidget {
  final void Function() togglePages;
  Register({super.key, required this.togglePages});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1808149181.
  void register() async {
    setState(() {
      isLoading = true;
    });
    try {
      //await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(emailController.text)
          .set({
        "username": usernameController.text,
        "email": emailController.text,
        "address": addressController.text,
        "contact": contactnoController.text,
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoadingScreen()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      // TODO
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
   
  }

  bool isLoading = false;

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

// Suggested code may be subject to a license. Learn more: ~LicenseLog:301602638.
  final TextEditingController repasswordController = TextEditingController();

  final TextEditingController contactnoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return AppLoader();
    }
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
                    height: 50,
                  ),
                  const Text("register",
                      style: TextStyle(
                        fontSize: 30,
                      )),
                  TextLogo(
                       text: '',
                    color: AppColors.primaryColor,
                    fontSize: 40,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AuthTextfield(
                    hintText: 'enter the username',
                    controller: usernameController,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthTextfield(
                    hintText: 'Enter the email',
                    controller: emailController,
                    obscureText: false,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  IntlPhoneField(
                    decoration: InputDecoration(
                      fillColor: AppColors.onsurfaceColor,
                      filled: true,
                      hintText: "contact no",
                      hintStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    controller: contactnoController,
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthTextfield(
                    hintText: 'Address',
                    controller: addressController,
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
                  const SizedBox(
                    height: 10,
                  ),
                  AuthTextfield(
                    hintText: 'Re-enter the Password',
                    controller: repasswordController,
                    obscureText: true,
                  ),
                  // Suggested code may be subject to a license. Learn more: ~LicenseLog:2877098626.
                  const SizedBox(
                    height: 30,
                  ),

                  MaterialButton(
                    onPressed: () {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          repasswordController.text.isNotEmpty &&
                          usernameController.text.isNotEmpty &&
                          addressController.text.isNotEmpty &&
                          contactnoController.text.isNotEmpty) {
                        if (passwordController.text ==
                            repasswordController.text) {
                          if (passwordController.text.length >= 6) {
                            if (EmailValidator.validate(emailController.text)) {
                              register();
                            } else {
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
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()))
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "The Password must be at least 6 characters long",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            //display alert message for password length
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Password Mismatch",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          //display alert message for password mismatch
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please fill all the fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        //display alert message for empty fields
                      }
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()))
                    },
                    color: AppColors.primaryColor,
                    child: const Text("Register"),
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
                      const Text("Already have an account?"),
                      TextButton(
                          onPressed: widget.togglePages,
                          child: const Text("Login"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
