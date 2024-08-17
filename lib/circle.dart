import 'package:flutter/material.dart';
import 'package:myapp/data/constants/app_colors.dart';

class MyCircle extends StatelessWidget {
  final String name, image;

// Suggested code may be subject to a license. Learn more: ~LicenseLog:4189012294.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:149343360.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2063891837.
  const MyCircle({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(name)
          ],
        ));
  }
}
