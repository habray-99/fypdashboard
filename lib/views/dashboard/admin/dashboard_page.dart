import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard/dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Total Revenue This Month: \$${controller.dashboardData['total_revenue_this_month']}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                      SizedBox(
                        height: 300,
                        child: BarChart(
                          BarChartData(
                            barGroups: _createChartData(
                              controller.dashboardData['12_month_history'],
                            ),
                          ),
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
                      DataTable(
                        columns: const [
                          DataColumn(label: Text('Payment ID')),
                          DataColumn(label: Text('Member ID')),
                          DataColumn(label: Text('Gym ID')),
                          DataColumn(label: Text('Months')),
                          DataColumn(label: Text('Till')),
                          DataColumn(label: Text('Valid')),
                        ],
                        rows: controller.dashboardData['recent_payments']
                            .map<DataRow>((payment) => DataRow(
                                  cells: [
                                    DataCell(Text('${payment['payment_id']}')),
                                    DataCell(Text('${payment['member_id']}')),
                                    DataCell(Text('${payment['gym_id']}')),
                                    DataCell(Text('${payment['months']}')),
                                    DataCell(Text('${payment['tillwhen']}')),
                                    DataCell(Text(payment['is_valid'] == '1'
                                        ? 'Yes'
                                        : 'No')),
                                  ],
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

  List<BarChartGroupData> _createChartData(List<dynamic> monthlyData) {
    return monthlyData.map((item) {
      final monthStr = item['month'].toString().substring(5, 7);
      final month = int.tryParse(monthStr);
      if (month != null) {
        return BarChartGroupData(
          x: month,
          barRods: [
            BarChartRodData(
              toY: double.parse(item['total_memberships_sold']),
              color: Colors.blue,
            ),
          ],
        );
      } else {
        // Handle invalid month format
        return BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: Colors.blue,
            ),
          ],
        );
      }
    }).toList();
  }
}
