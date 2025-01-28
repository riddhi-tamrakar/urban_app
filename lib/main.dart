import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'utils/route.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB_8-lxy3Mma1PoVYq0HrsZufmV6iRR4yM",
      appId: "1:616633614046:android:04cc91895540369992cc4f",
      messagingSenderId: "616633614046",
      projectId: "uxeloft-e9eaa",
    ),
  );
  Get.lazyPut(() => AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Firebase Login',
      theme: AppThemes.lightTheme,
      initialRoute: '/', // Define the initial route
      getPages: AppRoutes.pages, // Use the pages defined in AppRoutes
    );
  }
}
