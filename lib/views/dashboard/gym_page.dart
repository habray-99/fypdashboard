
import 'package:flutter/material.dart';
import 'package:fypdashboard/views/dashboard/add_gym_dialog.dart';
import 'package:fypdashboard/views/dashboard/gym_edit_diaglog.dart';
import 'package:fypdashboard/views/dashboard/sidebar.dart';
import 'package:get/get.dart';

import '../../controller/dashboard/gym_page_controller.dart';

class GymPage extends StatelessWidget {
  final GymPageController controller = Get.put(GymPageController());
  final TextEditingController _searchController = TextEditingController();

  GymPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: Row(
          children: [
            const Sidebar(),
            Expanded(
              child: SelectionArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: 'Search Gyms',
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                        ],
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
                              builder: (context) => const AddGymDialog(),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Gym'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(() {
                        if (controller.gyms.isEmpty) {
                          // Show loading indicator while fetching data
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          // Show gyms once fetched in a table
                          return SingleChildScrollView(
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Address')),
                                DataColumn(label: Text('Phone')),
                                DataColumn(label: Text('Email')),
                                DataColumn(label: Text('Price')),
                                DataColumn(label: Text('Photo')),
                                DataColumn(label: Text('Actions')),
                              ],
                              rows: controller.gyms
                                  .where((gym) => gym.gymName!
                                      .toLowerCase()
                                      .contains(
                                          _searchController.text.toLowerCase()))
                                  .map(
                                    (gym) => DataRow(
                                      cells: [
                                        DataCell(Text(gym.gymName ?? '')),
                                        DataCell(
                                          Text(gym.gymAddress ?? ''),
                                        ),
                                        DataCell(Text(gym.gymPhone ?? '')),
                                        DataCell(Text(gym.gymEmail ?? '')),
                                        DataCell(Text(gym.gymPrice.toString())),
                                        DataCell(
                                          gym.gymPhotos != null
                                              ? Image.network(gym.gymPhotos!)
                                              : const SizedBox(),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () {
                                                  // Implement edit functionality
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                      child: EditGymDialog(
                                                        gymId: gym.gymId ?? 0,
                                                        oldName:
                                                            gym.gymName ?? '',
                                                        oldAddress:
                                                            gym.gymAddress ??
                                                                '',
                                                        oldEmail:
                                                            gym.gymEmail ?? '',
                                                        oldPhone:
                                                            gym.gymPhone ?? '',
                                                        oldPhotos:
                                                            gym.gymPhotos ?? '',
                                                        oldPrice:
                                                            gym.gymPrice ?? 0,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () {
                                                  // Implement delete functionality
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                          'Delete Gym'),
                                                      content: const Text(
                                                          'Are you sure you want to delete this gym?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context); // Close dialog
                                                          },
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            controller
                                                                .deleteGym(
                                                                    gym.gymId!);
                                                            Navigator.pop(
                                                                context); // Close dialog
                                                          },
                                                          child: const Text(
                                                              'Delete'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
