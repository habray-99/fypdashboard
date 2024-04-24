import 'package:flutter/material.dart';
import 'package:fypdashboard/views/dashboard/admin/dashboard_page.dart';
import 'package:fypdashboard/views/dashboard/sidebar.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            flex: 2,
            child: DashboardPage(),
            // padding: const EdgeInsets.all(16),
            // child: const Center(
            //   child: Text('Admin Content Area'),
            // ),
          ),
        ],
      ),
    );
  }
}
