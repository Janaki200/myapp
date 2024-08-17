import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Authentication/login_or_register.dart';
import 'package:myapp/home.dart';

class AuthState extends StatelessWidget {
  const AuthState({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
      if (snapshot.hasData) {
        return MyHomePage();
      }else   {
        return LoginOrRegister();
      }
    },);
  }
}