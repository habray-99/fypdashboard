
import 'package:flutter/material.dart';
import 'package:fypdashboard/utils/image_paths.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final c = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      body: const Column(
        children: [
          Center(
            child: SizedBox(
              child: Image(
                image: AssetImage(
                  ImagePath.loginBackGround,
                  // ImagePath.splashLogo,
                ),
                height: 200,
                width:200,
              ),
            ),
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}
