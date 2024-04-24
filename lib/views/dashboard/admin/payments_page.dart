import 'package:flutter/material.dart';
import 'package:fypdashboard/controller/dashboard/gym_memberships_controller.dart';
import 'package:fypdashboard/views/dashboard/gymowner/add_member_dialog.dart';
import 'package:fypdashboard/views/dashboard/sidebar.dart';
import 'package:get/get.dart';

class AdminPayments extends StatelessWidget {
  const AdminPayments({super.key});

  @override
  Widget build(BuildContext context) {
    final MemberShipsController memberController =
        Get.put(MemberShipsController());

    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          memberController.filterMembers(value);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  memberController.toggleSortOrder();
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 15.0,
                      ),
                      Obx(
                        () => Icon(memberController.isSortedAscending.value
                            ? Icons.arrow_downward
                            : Icons.arrow_upward),
                      ),
                      Obx(
                        () => Text(memberController.isSortedAscending.value
                            ? 'Sort by Valid Memberships (Ascending)'
                            : 'Sort by Valid Memberships (Descending)'),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implement add gym functionality
                      showDialog(
                        context: context,
                        builder: (context) => const AddMemberDialog(),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add New Member'),
                  ),
                ),
              ),
              //   Expanded(
              //     child: Obx(
              //       () => memberController.isLoading.value
              //           ? const Center(child: CircularProgressIndicator())
              //           : SingleChildScrollView(
              //               child: DataTable(
              //                 columns: const [
              //                   DataColumn(label: Text('Payment ID')),
              //                   DataColumn(label: Text('Member ID')),
              //                   DataColumn(label: Text('Name')),
              //                   // DataColumn(label: Text('Email')),
              //                   DataColumn(label: Text('GymId')),
              //                   DataColumn(label: Text('Gym Name')),
              //                   DataColumn(label: Text('paymentDate')),
              //                   DataColumn(label: Text('for months')),
              //                   DataColumn(label: Text('till when')),
              //                   DataColumn(label: Text('Membership')),
              //                 ],
              //                 rows: memberController.filteredMembers
              //                     .map((member) => DataRow(cells: [
              //                           DataCell(
              //                               Text(member.paymentId!.toString())),
              //                           DataCell(
              //                               Text(member.memberId!.toString())),
              //                           DataCell(Text(member.memberName!)),
              //                           // DataCell(Text(member.memberEmail!)),
              //                           DataCell(
              //                               Text(member.gymId!.toString())),
              //                           DataCell(Text(member.gymName!)),
              //                           DataCell(Text(member.paymentDate!)),
              //                           DataCell(
              //                               Text(member.months!.toString())),
              //                           DataCell(Text(member.tillwhen!)), // ),
              //                           DataCell(
              //                             member.isValid! == 1
              //                                 ? Container(
              //                                     padding: const EdgeInsets.all(
              //                                         8.0), // Adjust padding as needed
              //                                     decoration: BoxDecoration(
              //                                       color:
              //                                           Colors.greenAccent[400],
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               10.0), // Adjust borderRadius as needed
              //                                     ),
              //                                     child: const Text(
              //                                       'Active',
              //                                       style: TextStyle(
              //                                           color: Color(
              //                                               0xFFF5F5F5)), // Ensure text color contrasts with the background
              //                                     ),
              //                                   )
              //                                 : Container(
              //                                     padding: const EdgeInsets.all(
              //                                         8.0), // Adjust padding as needed
              //                                     decoration: BoxDecoration(
              //                                       color:
              //                                           Colors.pinkAccent[400],
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               10.0), // Adjust borderRadius as needed
              //                                     ),
              //                                     child: Text(
              //                                       'Expired',
              //                                       style: TextStyle(
              //                                           color: Colors
              //                                                   .lightBlueAccent[
              //                                               50]), // Ensure text color contrasts with the background
              //                                     ),
              //                                   ),
              //                           ),
              //                         ]))
              //                     .toList(),
              //               ),
              //             ),
              //     ),
              //   ),
              // ],
              Expanded(
                child: Obx(
                  () => memberController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Payment ID')),
                              DataColumn(label: Text('Member ID')),
                              DataColumn(label: Text('Name')),
                              // DataColumn(label: Text('Email')),
                              DataColumn(label: Text('GymId')),
                              DataColumn(label: Text('Gym Name')),
                              DataColumn(label: Text('paymentDate')),
                              DataColumn(label: Text('for months')),
                              DataColumn(label: Text('till when')),
                              DataColumn(label: Text('Membership')),
                            ],
                            rows: memberController.filteredMembers
                                .map((member) => DataRow(cells: [
                                      DataCell(Text(
                                          member.paymentId?.toString() ??
                                              'N/A')),
                                      DataCell(Text(
                                          member.memberId?.toString() ??
                                              'N/A')),
                                      DataCell(
                                          Text(member.memberName ?? 'N/A')),
                                      // DataCell(Text(member.memberEmail ?? 'N/A')),
                                      DataCell(Text(
                                          member.gymId?.toString() ?? 'N/A')),
                                      DataCell(Text(member.gymName ?? 'N/A')),
                                      DataCell(
                                          Text(member.paymentDate ?? 'N/A')),
                                      DataCell(Text(
                                          member.months?.toString() ?? 'N/A')),
                                      DataCell(Text(member.tillwhen ?? 'N/A')),
                                      DataCell(
                                        member.isValid == 1
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  color:
                                                      Colors.greenAccent[400],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: const Text(
                                                  'Active',
                                                  style: TextStyle(
                                                      color: Color(0xFFF5F5F5)),
                                                ),
                                              )
                                            : Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.pinkAccent[400],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Text(
                                                  'Expired',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .lightBlueAccent[50]),
                                                ),
                                              ),
                                      ),
                                    ]))
                                .toList(),
                          ),
                        ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
