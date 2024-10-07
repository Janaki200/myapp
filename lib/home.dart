//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/cart_view_page.dart';

import 'package:myapp/data/constants/app_colors.dart';
import 'package:myapp/data/constants/food_model.dart';
import 'package:myapp/data/constants/logo.dart';
import 'package:myapp/loading_screen.dart';
import 'package:myapp/food_item_card.dart';
import 'package:myapp/order_page.dart';
import 'package:myapp/profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List items = [];
  List suggestions = [];
  List filteredItems = [];
  String selectedFilter = "";
  List<Map> cartItems = [];
  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  void initData() {
    setState(() {
      items = FoodModel.foodItems;
      suggestions = FoodModel.suggestions;
      filteredItems = FoodModel.foodItems;
    });
    filter(selectedCategory: "All");
  }

  void filter({required String selectedCategory}) {
    if (selectedCategory == 'All') {
      setState(() {
        filteredItems = items;
        selectedFilter = selectedCategory;
      });
    } else {
      setState(() {
        filteredItems = items.where((item) {
          return item['category'] == selectedCategory;
        }).toList();
        selectedFilter = selectedCategory;
      });
    }
  }

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
          iconTheme: IconThemeData(color: AppColors.surfaceColor),
          backgroundColor: AppColors.primaryColor,
          title: const TextLogo(
               text: '',
            color: AppColors.surfaceColor,
            fontSize: 20,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 50,
                width: 50,
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CartViewPage(cartItems: cartItems);
                            },
                          ));
                        },
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: AppColors.surfaceColor,
                          size: 40,
                        )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: AppColors.surfaceColor,
                            borderRadius: BorderRadius.circular(360)),
                        child: Text(
                          cartItems.length.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
       
        body: Column(
          children: [
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3580083208.
            //deit hut suggestions
            Container(
              height: 120,
              child: ListView.builder(
                  itemCount: suggestions.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          filter(selectedCategory: suggestions[index]['name']);
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: selectedFilter ==
                                            suggestions[index]['name']
                                        ? Border.all(
                                            color: AppColors.primaryColor,
                                            width: 3)
                                        : Border.all(color: Colors.black),
                                    color: AppColors.surfaceColor,
                                    image: suggestions[index]['image']
                                            .isNotEmpty
                                        ? DecorationImage(
                                            image: AssetImage(
                                                suggestions[index]['image']),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: suggestions[index]['image'].isEmpty
                                      ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.food_bank,
                                            size: 50,
                                            color: AppColors.primaryColor,
                                          ),
                                        )
                                      : null,
                                ),
                                Text(suggestions[index]['name'])
                              ],
                            )));
                  }),
            ),

// Suggested code may be subject to a license. Learn more: ~LicenseLog:2410168198.
            //deit hut posts
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return FoodItemCard(
                    addItemCart: ({required data, required price}) {
                      setState(() {
                        cartItems.add(data);
                      });
                    },
                    category: filteredItems[index]['category'],
                    description: filteredItems[index]['description'],
                    image: filteredItems[index]['image'],
                    name: filteredItems[index]['name'],
                    price: filteredItems[index]['price'],
                    recipe: filteredItems[index]['recipe'],
                    customValues: filteredItems[index]['customValues'],
                    isCustomisable: filteredItems[index]['isCustomizable'],
                    cartList: cartItems,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
