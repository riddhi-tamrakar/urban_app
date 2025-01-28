import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../views/bottom_navigation.dart';
import '../views/login.dart';


class AppRoutes {
  // A static list of pages (routes) used in GetX routing
  static final List<GetPage> pages = [
     GetPage(
      name: '/',
      page: () {
        final authController = Get.find<AuthController>();
        authController.checkLoginStatus(); // Check login status on app start
        // Navigate to the appropriate screen
        return authController.isLoggedIn.value ? BottomNavigation() : LoginScreen();
      },
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      transition: Transition.fadeIn, // Optional: You can add transitions here
    ),
    GetPage(
      name: '/bottomNavigation',
      page: () => BottomNavigation(),
      transition: Transition.fadeIn,
    ),
  ];
}
