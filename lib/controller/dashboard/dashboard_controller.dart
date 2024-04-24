import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController {
  final _dashboardData =
      <String, dynamic>{}.obs; // Initialize as Map<String, dynamic>

  Map<String, dynamic> get dashboardData => _dashboardData.value;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    // Replace with the actual URL to fetch the JSON data
    final response = await http
        .get(Uri.parse('http://localhost/fyp_backend/apis/admindashboard.php'));

    if (response.statusCode == 200) {
      _dashboardData.value = jsonDecode(response.body);
    } else {
      // Handle error
    }
  }
}
