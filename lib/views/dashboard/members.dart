import 'package:flutter/material.dart';
import 'package:fypdashboard/views/dashboard/sidebar.dart';
import 'package:get/get.dart';

import '../../controller/dashboard/gym_member_controller.dart';

class DataTablePage extends StatelessWidget {
  const DataTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MemberController memberController = Get.put(MemberController());

    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      memberController.filterMembers(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => memberController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Email')),
                                DataColumn(label: Text('Phone')),
                                DataColumn(label: Text('paymentDate')),
                                DataColumn(label: Text('for months')),
                                DataColumn(label: Text('till when')),
                                DataColumn(label: Text('Membership')),
                              ],
                              rows: memberController.filteredMembers
                                  .map((member) => DataRow(cells: [
                                        DataCell(
                                            Text(member.memberId!.toString())),
                                        DataCell(Text(member.memberName!)),
                                        DataCell(Text(member.memberEmail!)),
                                        DataCell(Text(member.memberPhone!)),
                                        DataCell(Text(member.paymentDate!)),
                                        DataCell(
                                            Text(member.months!.toString())),
                                        DataCell(Text(member.tillwhen!)), // ),
                                        DataCell(
                                          member.isValid! == 1
                                              ? Container(
                                                  padding: const EdgeInsets.all(
                                                      8.0), // Adjust padding as needed
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFF5F5F5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0), // Adjust borderRadius as needed
                                                  ),
                                                  child: const Text(
                                                    'Active',
                                                    style: TextStyle(
                                                        color: Color(
                                                            0xFFF5F5F5)), // Ensure text color contrasts with the background
                                                  ),
                                                )
                                              : Container(
                                                  padding: const EdgeInsets.all(
                                                      8.0), // Adjust padding as needed
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.pinkAccent[400],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0), // Adjust borderRadius as needed
                                                  ),
                                                  child: Text(
                                                    'Inactive',
                                                    style: TextStyle(
                                                        color: Colors
                                                                .lightBlueAccent[
                                                            50]), // Ensure text color contrasts with the background
                                                  ),
                                                ),
                                        ),
                                      ]))
                                  .toList(),
                            ),
                          ),
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
