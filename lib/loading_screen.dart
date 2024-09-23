import 'package:flutter/material.dart';
import 'package:myapp/Authentication/auth_state.dart';
//import 'package:myapp/Authentication/login.dart';
//import 'package:myapp/Authentication/login_or_register.dart';
import 'package:myapp/data/constants/app_colors.dart';
import 'package:myapp/data/constants/logo.dart';
//import 'package:myapp/home.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key}); 

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isloaded=true;
  @override
  void initState() {
    loadsplash();
    // TODO: implement initState
    super.initState();
  }
  void loadsplash() async{
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      isloaded=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (isloaded
    ) {
  return Scaffold(
    backgroundColor:AppColors.primaryColor,
    body: Center(
      child: TextLogo(
           text: '',
                    color: AppColors.surfaceColor,
                    fontSize: 50,
                  ),
    ),
  );
}else{
  return AuthState();
}
  }
}
