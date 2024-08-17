import 'package:flutter/material.dart';
import 'package:myapp/data/constants/app_colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.surfaceColor,
      body: Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor,),
      ),
    );
  }
}