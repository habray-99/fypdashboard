
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard/gym_page_controller.dart';


class EditGymDialog extends StatelessWidget {
  final int gymId;
  final String oldName;
  final String oldAddress;
  final String oldPhone;
  final String oldEmail;
  final String oldPhotos;
  final int oldPrice;

  const EditGymDialog({
    super.key,
    required this.gymId,
    required this.oldName,
    required this.oldAddress,
    required this.oldPhone,
    required this.oldEmail,
    required this.oldPhotos,
    required this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GymPageController>(
      builder: (controller) {
        TextEditingController nameController =
            TextEditingController(text: oldName);
        TextEditingController addressController =
            TextEditingController(text: oldAddress);
        TextEditingController phoneController =
            TextEditingController(text: oldPhone);
        TextEditingController emailController =
            TextEditingController(text: oldEmail);
        TextEditingController photosController =
            TextEditingController(text: oldPhotos);
        TextEditingController priceController =
            TextEditingController(text: oldPrice.toString());

        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.cyan,
            title: const Text('Edit Gym'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'New Name'),
                  ),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'New Address'),
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'New Phone'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'New Email'),
                  ),
                  TextField(
                    controller: photosController,
                    decoration: const InputDecoration(labelText: 'New Photos'),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: 'New Price'),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  String newName = nameController.text.trim();
                  String newAddress = addressController.text.trim();
                  String newPhone = phoneController.text.trim();
                  String newEmail = emailController.text.trim();
                  String newPhotos = photosController.text.trim();
                  int newPrice = int.tryParse(priceController.text.trim()) ?? 0;
                  controller.editGym(gymId, newName, newAddress, newPhone,
                      newEmail, newPhotos, newPrice);
                  Navigator.pop(context); // Close dialog
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
