import 'package:flutter/material.dart';
import 'package:myapp/Authentication/login.dart';
import 'package:myapp/Authentication/register.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showregisterPage=false;
  void togglePages(){
    setState(() {
      showregisterPage=!showregisterPage;
    });
  }
  @override
  Widget build(BuildContext context) {
  if(showregisterPage){
    return Register(togglePages: togglePages);
   
  }else{
    return MyloginPage(togglePages: togglePages);
  }
}
}