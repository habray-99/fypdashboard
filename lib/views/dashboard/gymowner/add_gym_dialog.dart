import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/dashboard/gym_page_controller.dart';
import '../../../models/gym.dart';

class AddGymDialog extends StatefulWidget {
  const AddGymDialog({super.key});

  @override
  _AddGymDialogState createState() => _AddGymDialogState();
}

class _AddGymDialogState extends State<AddGymDialog> {
  final GymPageController _controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  final _gymNameController = TextEditingController();
  final _gymAddressController = TextEditingController();
  final _gymPhoneController = TextEditingController();
  final _gymEmailController = TextEditingController();
  final _gymPriceController = TextEditingController();

  File? _gymImage;
  String? _gymImagePath; // Store the path instead of the File object

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _gymImagePath = pickedImage.path; // Store the path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _gymNameController,
                  decoration: const InputDecoration(
                    labelText: 'Gym Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a gym name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _gymAddressController,
                  decoration: const InputDecoration(
                    labelText: 'Gym Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a gym address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _gymPhoneController,
                  decoration: const InputDecoration(
                    labelText: 'Gym Phone',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a gym phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _gymEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Gym Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a gym email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _gymPriceController,
                  decoration: const InputDecoration(
                    labelText: 'Gym Price',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a gym price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pick Gym Image'),
                ),
                const SizedBox(height: 16.0),
                if (_gymImage != null)
                  if (_gymImagePath != null)
                    Image.asset(
                      _gymImagePath!,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final gym = Gyms(
                        gymName: _gymNameController.text,
                        gymAddress: _gymAddressController.text,
                        gymPhone: _gymPhoneController.text,
                        gymEmail: _gymEmailController.text,
                        gymPrice: int.tryParse(_gymPriceController.text),
                        gymPhotos: _gymImagePath, // Use _gymImagePath here
                      );

                      _controller.addGym(gym, _gymImage);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add Gym'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _gymNameController.dispose();
    _gymAddressController.dispose();
    _gymPhoneController.dispose();
    _gymEmailController.dispose();
    _gymPriceController.dispose();
    super.dispose();
  }
}
