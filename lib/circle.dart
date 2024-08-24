import 'package:flutter/material.dart';
import 'package:myapp/data/constants/app_colors.dart';

class MyCircle extends StatelessWidget {
  final String name, image;
  final BoxBorder border;

  const MyCircle({super.key, required this.name, required this.image,required this.border});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:border,
                color: AppColors.surfaceColor,
                image:image.isNotEmpty? DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ):null,
              ),
              child: image.isEmpty? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.food_bank,size: 60,color: AppColors.primaryColor,),
              ):null,
            ),
            Text(name)
          ],
        ));
  }
}
