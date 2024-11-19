import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_23/component/my_colors.dart';
import 'package:pas1_mobile_11pplg1_23/controllers/auth_controller.dart';
import 'package:pas1_mobile_11pplg1_23/controllers/bottom_navbar_controller.dart';
import 'package:pas1_mobile_11pplg1_23/pages/favorite_page.dart';
import 'package:pas1_mobile_11pplg1_23/pages/home.dart';
import 'package:pas1_mobile_11pplg1_23/pages/profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final BottomnavbarController bottomnavbarController =
      Get.put(BottomnavbarController());

  @override
  Widget build(BuildContext context) {
    final List<Widget> menus = [
      Home(),
      FavoritePage(),
      ProfilePage(
        authController: Get.find<AuthController>(),
      ),
    ];

    return Obx(() {
      return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            body: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: menus[bottomnavbarController.selectedIndex.value],
            ),
            bottomNavigationBar: Container(
              height: 90,
              decoration: BoxDecoration(
                color: AppColor.primaryBlue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavItem(Icons.home_rounded, 'Home', 0),
                      _buildNavItem(Icons.favorite_rounded, 'Favorite', 1),
                      _buildNavItem(Icons.person_rounded, 'Profile', 2),
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return Obx(() {
      final isSelected = bottomnavbarController.selectedIndex.value == index;
      return GestureDetector(
        onTap: () => bottomnavbarController.changedTabIndex(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.bounceIn,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: Duration(microseconds: 700),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(isSelected ? 8 : 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColor.primaryBlue : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color:
                      isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                  size: 24,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
