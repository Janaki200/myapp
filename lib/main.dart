import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
//import 'package:myapp/Authentication/login.dart';
import 'package:myapp/loading_screen.dart';
//mport 'package:myapp/loading_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
 runApp(const MyApp());
}
//cupertino(Ios)
//Material
class MyApp  extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );//MaterialApp
  }
}
