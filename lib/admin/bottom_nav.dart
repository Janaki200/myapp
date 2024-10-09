import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/admin/completed_orders.dart';
import 'package:myapp/admin/order.dart';
import 'package:myapp/admin/outfor_delivery.dart';
import 'package:myapp/data/constants/app_colors.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class AdminBottomNav extends StatefulWidget {
  const AdminBottomNav({super.key});

  @override
  State<AdminBottomNav> createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  int selectedIndex = 0;
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          //this color must be equal to the WaterDropNavBar backgroundColor
          systemNavigationBarColor: AppColors.surfaceColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children:  [Order(), OutforDelivery(), CompletedOrders()],
          ),
          bottomNavigationBar: WaterDropNavBar(
            waterDropColor: AppColors.primaryColor,
            backgroundColor: AppColors.surfaceColor,
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
                filledIcon: Icons.food_bank,
                outlinedIcon: Icons.food_bank_outlined,
              ),
              BarItem(
                  filledIcon: Icons.delivery_dining_rounded,
                  outlinedIcon: Icons.delivery_dining_outlined),
              BarItem(
                filledIcon: Icons.check_box,
                outlinedIcon: Icons.check_box_outlined,
              ),
            ],
          ),
        ));
  }
}
