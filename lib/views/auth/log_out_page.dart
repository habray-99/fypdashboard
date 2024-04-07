import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/core_controller.dart';
import '../dashboard/sidebar.dart';

class LogOutPage extends StatelessWidget {
  const LogOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.find<CoreController>().logOut();
                },
                child: const Text('Log Out'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
