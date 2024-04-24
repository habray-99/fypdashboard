import 'package:flutter/material.dart';
import 'package:fypdashboard/views/dashboard/report_generation.dart';
import 'package:fypdashboard/views/dashboard/sidebar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            // child: Container(
            // padding: const EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(18.0),
              // child: ReportPage(),
              child: BarChartSample(),
            ),
          ),
          // )
        ],
      ),
    );
  }
}
