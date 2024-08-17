import 'package:flutter/material.dart';
import 'package:myapp/data/constants/app_colors.dart';

class MySquare extends StatelessWidget {
  final String name, description, recipe, price, category, image;

// Suggested code may be subject to a license. Learn more: ~LicenseLog:1553142816.
  MySquare(
      {super.key,
      required this.name,
      required this.description,
      required this.recipe,
      required this.price,
      required this.category,
      required this.image});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryColor)),
          alignment: Alignment.bottomCenter,
          height: 300,
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4127700794.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2604778083.

// Suggested code may be subject to a license. Learn more: ~LicenseLog:705565838.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2016395154.
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              height: 130,
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover),
                  color: Colors.white),
            ),
            Text(name),
            Text(description),
            Text(price),
            Text(category)
          ])),
    );
  }
}
