
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_details.dart';
import '../utils/storage_keys.dart';
import '../views/auth/login_page.dart';

class CoreController extends GetxController {
  Rx<UserDetail?> currentUser = Rxn<UserDetail>();
  RxString userToken = "".obs;
  @override
  void onInit() async {
    try {
      await loadCurrentUser();
    // ignore: empty_catches
    } catch (e) {}
    super.onInit();
  }

  Future<void> loadCurrentUser() async {
    currentUser.value = StorageHelper.getUser();
    userToken.value = StorageHelper.getToken();
    log("current user----------------------- ${currentUser.value?.memberEmail}-");
    log("current user token----------------------- ${userToken.value}-");
  }

  bool isUserLoggedIn() {
    return currentUser.value != null;
  }

  void logOut() async {
    final box = GetStorage();
    // await box.write(StorageKeys.ACCESS_TOKEN, null);
    await box.write(StorageKeys.USER, null);
    loadCurrentUser();
    Get.offAll(() => const LogInScreen());
  }
}
