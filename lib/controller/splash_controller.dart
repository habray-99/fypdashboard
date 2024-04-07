import 'dart:async';

import 'package:fypdashboard/controller/core_controller.dart';
import 'package:fypdashboard/views/dashboard/home_page.dart';
import 'package:get/get.dart';

import '../views/auth/login_page.dart';

class SplashScreenController extends GetxController {
  final c = Get.put(CoreController());
  @override
  void onInit() {
    Timer(const Duration(seconds: 4), () async {
      if (c.isUserLoggedIn()) {
        Get.offAll(const HomePage());
      } else {
        Get.offAll(const LogInScreen());
      }
    });
    super.onInit();
  }
}
