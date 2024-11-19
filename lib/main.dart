import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_23/controllers/api_service.dart';
import 'package:pas1_mobile_11pplg1_23/controllers/auth_controller.dart';
import 'package:pas1_mobile_11pplg1_23/controllers/bottom_navbar_controller.dart';
import 'package:pas1_mobile_11pplg1_23/databases/task_controller.dart';
import 'package:pas1_mobile_11pplg1_23/pages/home_page.dart';
import 'package:pas1_mobile_11pplg1_23/pages/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(BottomnavbarController());
  final authController = Get.put(AuthController());
  Get.put(FavoriteTeamController());
  await authController.initializeController();
  await ApiService.initializeToken();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Get.find<AuthController>().loadUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return Obx(
            () {
              final authController = Get.find<AuthController>();
              return authController.isLoggedIn.value
                  ? HomePage()
                  : const LoginPage();
            },
          );
        },
      ),
    );
  }
}
