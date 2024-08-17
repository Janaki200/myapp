import 'package:flutter/material.dart';
import 'package:myapp/data/constants/app_colors.dart';

class AuthTextfield extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  const AuthTextfield({super.key, required this.hintText, required this.controller,required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return  TextField(obscureText: obscureText,
            controller: controller,
                decoration:   InputDecoration(
                  fillColor: AppColors.onsurfaceColor,
                  filled: true,
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 4),
                  borderRadius: BorderRadius.circular(12),                  
           ),
            ),     
                  
                );
  }
}