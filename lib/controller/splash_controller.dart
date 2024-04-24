import 'dart:async';

import 'package:fypdashboard/controller/core_controller.dart';
import 'package:fypdashboard/utils/storage_keys.dart';
import 'package:get/get.dart';

import '../views/auth/login_page.dart';
import '../views/dashboard/admin/admin_home_page.dart';
import '../views/dashboard/gymowner/home_page.dart';

class SplashScreenController extends GetxController {
  final c = Get.put(CoreController());
  @override
  void onInit() {
    Timer(const Duration(seconds: 0), () async {
      if (c.isUserLoggedIn()) {
        if (StorageHelper.getUserType() == 0) {
          Get.offAll(() => const AdminHomePage());
        } else {
          Get.offAll(const HomePage());
        }
      } else {
        Get.offAll(const LogInScreen());
      }
    });
    super.onInit();
  }
}
