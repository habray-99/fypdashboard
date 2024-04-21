import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard/dashboard_controller.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Obx(
        () => controller.dashboardData.isNotEmpty
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.dashboardData['message'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '12 Month History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: controller.dashboardData['12_month_history']
                            .map<Widget>((history) => ListTile(
                                  title: Text('Month: ${history['month']}'),
                                  trailing: Text(
                                      'Total Memberships Sold: ${history['total_memberships_sold']}'),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Total Revenue This Month: \$${controller.dashboardData['total_revenue_this_month']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Recent Payments',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: controller.dashboardData['recent_payments']
                            .map<Widget>((payment) => ListTile(
                                  title: Text('Payment ID: ${payment['payment_id']}'),
                                  subtitle: Text(
                                      'Member ID: ${payment['member_id']}, Gym ID: ${payment['gym_id']}, Months: ${payment['months']}, Till: ${payment['tillwhen']}, Valid: ${payment['is_valid'] == '1' ? 'Yes' : 'No'}'),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}