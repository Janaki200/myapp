//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/circle.dart';
import 'package:myapp/data/constants/app_colors.dart';
import 'package:myapp/data/constants/food_model.dart';
import 'package:myapp/data/constants/logo.dart';
import 'package:myapp/loading_screen.dart';
import 'package:myapp/squarew.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4099487741.
  final List _posts = [
    'post 1',
    'post 2',
    'post 3',
    'post 4',
    'post 5',
    'post 6'
  ];

  final List _stories = [
    'story 1',
    'story 2',
    'story 3',
    'story 4',
    'story 5',
    'story 6'
  ];
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoadingScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.surfaceColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: TextLogo(
            color: AppColors.surfaceColor,
            fontSize: 20,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: AppColors.surfaceColor,
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                    )),
              ),
            )
          ],
        ),
        body: Column(
          children: [
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3580083208.
            //deit hut suggestions
            Container(
              height: 150,
              child: ListView.builder(
                  itemCount: FoodModel.suggestions.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return MyCircle(
                      image: FoodModel.suggestions[index]['image'],
                      name: FoodModel.suggestions[index]['name'],
                    );
                  }),
            ),

// Suggested code may be subject to a license. Learn more: ~LicenseLog:2410168198.
            //deit hut posts
            Expanded(
              child: ListView.builder(
                itemCount: FoodModel.foodItems.length,
                itemBuilder: (context, index) {
                  return MySquare(
                    category: FoodModel.foodItems[index]['category'],
                    description: FoodModel.foodItems[index]['description'],
                    image: FoodModel.foodItems[index]['image'],
                    name: FoodModel.foodItems[index]['name'],
                    price: FoodModel.foodItems[index]['price'].toString(),
                    recipe: FoodModel.foodItems[index]['recipe'],
                  );
                  // Suggested code may be subject to a license. Learn more: ~LicenseLog:2578343940.
                },
              ),
            ),
          ],
        ));
  }
}
