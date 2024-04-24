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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .1),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("Are you sure you want to log out?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .1),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.find<CoreController>().logOut();
                    },
                    child: const Text('Log Out'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
