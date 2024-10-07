import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/data/constants/app_colors.dart';
import 'package:myapp/home.dart';
import 'package:myapp/order_page.dart';
import 'package:myapp/profile.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({ super.key });

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
     value: const SystemUiOverlayStyle(
       //this color must be equal to the WaterDropNavBar backgroundColor
       systemNavigationBarColor:  AppColors.primaryColor,
       systemNavigationBarIconBrightness: Brightness.dark,
     ),
     child: Scaffold(
       body: PageView(
      physics: const NeverScrollableScrollPhysics(),       
      controller: pageController,
      children: [

        MyHomePage(),
        OrderPage(),
        ProfilePage(),
      ],
      ),
      bottomNavigationBar: WaterDropNavBar(
        waterDropColor: Colors.white,
        backgroundColor: AppColors.primaryColor,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          pageController.animateToPage(selectedIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad);
        },
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            filledIcon: Icons.home_filled,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
              filledIcon: Icons.shopping_bag,
              outlinedIcon: Icons.shopping_bag_outlined),
                BarItem(
            filledIcon: Icons.person,
            outlinedIcon: Icons.person_2_outlined,
          ),
        
        ],
      ),
     )
);
  }
}