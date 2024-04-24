import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fypdashboard/views/dashboard/admin/admin_home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../repo/login_repo.dart';
import '../../utils/custom_snackbar.dart';
import '../../utils/storage_keys.dart';
import '../../views/dashboard/gymowner//home_page.dart';
import '../core_controller.dart';

class LogInController extends GetxController {
  final key = GlobalKey<FormState>();
  RxBool passwordObscure = true.obs;

  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  RxBool isChecked = false.obs;

  void onEyeCLick() {
    passwordObscure.value = !passwordObscure.value;
  }

  void onSubmit() async {
    if (key.currentState!.validate()) {
      loading.show(
        message: 'Please wait',
        hideText: true,
      );
      await LoginRepo.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        onSuccess: (user, token) async {
          loading.hide();
          final box = GetStorage();
          await box.write(StorageKeys.USER, json.encode(user.toJson()));
          await box.write(StorageKeys.ACCESS_TOKEN, token.toString());
          Get.find<CoreController>().loadCurrentUser();
          // Get.offAll(() => const HomePage());
          if (user.memberType == 2) {
            Get.offAll(() => const HomePage());
            await Future.delayed(const Duration(seconds: 1), () => {
            CustomSnackBar.success(title: "Login", message: "Login Successful")

            });
          } else if (user.memberType == 0) {
            Get.offAll(() => const AdminHomePage());
            await Future.delayed(const Duration(seconds: 1), () => {
            CustomSnackBar.success(
                title: "Login", message: "Admin Login Successful")

            });
          } else {
            CustomSnackBar.error(
                title: "Login", message: "Access Denied, Please contact Admin");
          }
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Login failed", message: message);
        },
      );
    }
  }
}
