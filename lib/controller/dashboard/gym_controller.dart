import 'package:flutter/material.dart';

class GymController {
  final key = GlobalKey<FormState>();
  final gymId = TextEditingController();
  final gymName = TextEditingController();
  final gymAddress = TextEditingController();
  final gymPhone = TextEditingController();
  final gymEmail = TextEditingController();
  final gymPhotos = TextEditingController();
  final gymPrice = TextEditingController();
  final userID = TextEditingController();

  void onSubmit() {
    if (key.currentState!.validate()) {}
  }
}
