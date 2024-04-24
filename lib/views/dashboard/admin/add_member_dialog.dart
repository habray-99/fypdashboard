import 'package:flutter/material.dart';
import 'package:fypdashboard/controller/dashboard/gym_member_controller.dart';
import 'package:fypdashboard/models/gym_member.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddMemberDialog extends StatefulWidget {
  const AddMemberDialog({super.key});

  @override
  _AddMemberDialogState createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  final _formKey1 = GlobalKey<FormState>();
  final _memberNameController = TextEditingController();
  final _memberEmailController = TextEditingController();
  final _memberPhoneController = TextEditingController();
  final _memberAddressController = TextEditingController();
  final _memberMonthsController = TextEditingController();
  final _memberTempPasswordController = TextEditingController();

  final MemberController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Member'),
      content: Form(
        key: _formKey1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _memberNameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _memberEmailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _memberPhoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(Icons.phone),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _memberAddressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.location_on),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an address';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _memberTempPasswordController,
              decoration: const InputDecoration(
                labelText: 'Temporary Password',
                prefixIcon: Icon(Icons.lock),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Temporary Password';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _memberMonthsController,
              decoration: const InputDecoration(
                labelText: 'Number of month(s)',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter months';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Starting from',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd')
                      .format(_controller.selectedDate.value)),
              readOnly: true,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _controller.selectedDate.value,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null &&
                    picked != _controller.selectedDate.value) {
                  _controller.selectedDate.value = picked;
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey1.currentState!.validate()) {
              // Add member logic here
              final member = GymMember(
                memberName: _memberNameController.text,
                memberEmail: _memberEmailController.text,
                memberPhone: _memberPhoneController.text,
                memberAddress: _memberAddressController.text,
                months: int.tryParse(_memberMonthsController.text),
                fromWhen: DateFormat('yyyy-MM-dd')
                    .format(_controller.selectedDate.value),
                memberPassword: _memberTempPasswordController.text,
              );
              _controller.addMember(member);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
