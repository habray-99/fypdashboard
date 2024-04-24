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
                      const Text(
                        "Welcome Admin",
                        style: TextStyle(fontSize: 28),
                      ),
                      const SizedBox(height: 16),
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
                      // const Text(
                      //   '12 Month History',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(height: 8),
                      // SizedBox(
                      //   height: 300,
                      //   child: LineChart(
                      //     LineChartData(
                      //       lineBarsData: [
                      //         LineChartBarData(
                      //           spots: _createChartData(
                      //             controller.dashboardData['12_month_history'],
                      //           ),
                      //           isCurved: true,
                      //           color: Colors.blue,
                      //           barWidth: 3,
                      //           isStrokeCapRound: true,
                      //           dotData: const FlDotData(
                      //             show: false,
                      //           ),
                      //           belowBarData: BarAreaData(
                      //             show: true,
                      //             color: Colors.blue.withOpacity(0.2),
                      //           ),
                      //         ),
                      //       ],
                      //       titlesData: FlTitlesData(
                      //         bottomTitles: AxisTitles(
                      //           sideTitles: SideTitles(
                      //             showTitles: true,
                      //             getTitlesWidget: (value, meta) {
                      //               final monthlyData = controller
                      //                   .dashboardData['12_month_history'];
                      //               if (value.toInt() >= 0 &&
                      //                   value.toInt() < monthlyData.length) {
                      //                 return Text(
                      //                     monthlyData[value.toInt()]['month']);
                      //               }
                      //               return const Text('');
                      //             },
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
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

  List<FlSpot> _createChartData(List<dynamic> monthlyData) {
    return monthlyData.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return FlSpot(
        index.toDouble(),
        double.parse(item['total_memberships_sold']),
      );
    }).toList();
  }
}
