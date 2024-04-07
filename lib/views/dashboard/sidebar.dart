import 'package:flutter/material.dart';
import 'package:fypdashboard/models/sidebar_item.dart';
import 'package:fypdashboard/views/dashboard/home_page.dart';
import 'package:fypdashboard/views/dashboard/members.dart';
import 'package:get/get.dart';

import '../auth/log_out_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          SidebarItem(
            title: 'Home',
            icon: Icons.home,
            onTap: () => Get.to(() => const HomePage()),
          ),
          const SidebarItem(
            title: 'Register Gym',
            icon: Icons.people,
            // onTap: () => Get.toNamed('/members'),
          ),
          SidebarItem(
            title: 'Members',
            icon: Icons.people,
            onTap: () => {Get.to(() => DataTablePage())},
          ),
          const SidebarItem(
            title: 'Gym Detail',
            icon: Icons.fitness_center,
            // onTap: () => Get.toNamed('/gym-detail'),
          ),
          SidebarItem(
            title: 'Logout',
            icon: Icons.logout_outlined,
            onTap: () => Get.to(() => const LogOutPage()),
          ),
          // Add more sidebar items here
        ],
      ),
    );
    // return Scaffold(
    //   body: Row(
    //     children: [
    //       SidebarX(
    //         controller: SidebarXController(selectedIndex: 0),
    //         items: [
    //           SidebarXItem(
    //             label: 'Home page',
    //             icon: Icons.home,
    //             onTap: () {
    //               Get.to(() => const HomePage());
    //             },
    //           ),
    //           SidebarXItem(
    //             label: 'Members',
    //             icon: Icons.people,
    //             onTap: () {
    //               // Get.toNamed('/members');
    //             },
    //           ),
    //           SidebarXItem(
    //             label: 'Gym Detail',
    //             icon: Icons.fitness_center,
    //             onTap: () {
    //               // Get.toNamed('/gym-detail');
    //             },
    //           ),
    //           SidebarXItem(
    //             label: 'Logout',
    //             icon: Icons.logout_outlined,
    //             onTap: () {
    //               Get.to(() => const LogOutPage());
    //             },
    //           ),
    //         ],
    //       ),
    //       // Your app screen body
    //     ],
    //   ),
    // );
  }
}
