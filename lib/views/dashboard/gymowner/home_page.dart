import 'package:flutter/material.dart';
import 'package:fypdashboard/views/dashboard/sidebar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: Text('Owner Content Area'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
