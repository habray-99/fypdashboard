import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fypdashboard/models/gym.dart';
import 'package:fypdashboard/utils/apis.dart';
import 'package:fypdashboard/utils/storage_keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Import this package
import 'package:mime/mime.dart'; // Import this package

class GymPageController extends GetxController {
  @override
  void onInit() {
    fetchGyms();
    super.onInit();
  }

  // Define a list to store gyms
  RxList<Gyms> gyms = <Gyms>[].obs;

  // Function to fetch gyms from API
  Future<void> fetchGyms() async {
    try {
      // Fetch the memberId using StorageHelper
      int? memberId = StorageHelper.getUserId();
      log("The logged in owner: $memberId");
      if (memberId != null) {
        final response = await http
            .get(Uri.parse('${Apis.getGymByOwnerUrl}?member_id=$memberId'));

        log("The fetched gym by owner response is: ${response.body}");

        if (response.statusCode == 200) {
          // If server returns success, parse the response
          List<dynamic> responseData = jsonDecode(response.body)['gyms'];
          // Convert the response data into list of Gyms objects
          gyms.value = gymDetailListFromJson(responseData);
        } else {
          throw Exception('Failed to load gyms');
        }
      } else {
        throw Exception('Failed to get memberId');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> addGym(Gyms gym, File? gymImage) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Apis.registerGymUrl), // Update your API endpoint
      );

      // Add gym data to the request fields
      request.fields.addAll({
        'gym_name': gym.gymName ?? '',
        'gym_address': gym.gymAddress ?? '',
        'gym_phone': gym.gymPhone ?? '',
        'gym_email': gym.gymEmail ?? '',
        'gym_price': gym.gymPrice.toString(),
        'gym_owner': StorageHelper.getUserId().toString(),
      });

      // Add gym image to the request body if available
      if (gymImage != null) {
        final mimeType = lookupMimeType(gymImage.path);
        var fileExtension = mimeType?.split('/').last;
        var fileName =
            '${gym.gymName}_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
        var fileStream = http.ByteStream(gymImage.openRead());
        var length = await gymImage.length();
        var fileHeader = http.MultipartFile(
          'gym_photos',
          fileStream,
          length,
          filename: fileName,
          contentType: MediaType('image', fileExtension!),
        );
        request.files.add(fileHeader);
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        await fetchGyms();
        Get.snackbar("Success", "Gym added successfully");
        gyms.clear();
        fetchGyms();
      } else {
        throw Exception('Failed to add gym');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> editGym(int gymId, String newName, String newAddress,
      String newPhone, String newEmail, String newPhotos, int newPrice) async {
    try {
      final response = await http.post(
        Uri.parse(Apis.updateGymUrl), // Update your API endpoint
        body: {
          'gym_id': gymId.toString(),
          'gym_name': newName,
          'gym_address': newAddress,
          'gym_phone': newPhone,
          'gym_email': newEmail,
          'gym_photos': newPhotos,
          'gym_price': newPrice.toString(),
        },
      );

      if (response.statusCode == 200) {
        await fetchGyms();
        Get.snackbar("Success", "Gym edited successfully");
        gyms.refresh();
        // Gym edited successfully
        // Now, you can update the gyms list or perform any other action
        // For example:
        // fetchGyms(); // Refresh gyms list after editing
      } else {
        throw Exception('Failed to edit gym');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Method to delete gym
  Future<void> deleteGym(int gymId) async {
    try {
      log("The logged in gym owner for delete: `$gymId`");
      final response = await http.post(
        Uri.parse(Apis.deleteGymUrl),
        body: {
          'gym_id': gymId.toString()
        }, // Ensure gymId is converted to string
      );

      if (response.statusCode == 200) {
        await fetchGyms();
        Get.snackbar("Success", "Gym deleted successfully");
        // Gym deleted successfully
        // Now, you can update the gyms list or perform any other action
        // For example:
        // fetchGyms(); // Refresh gyms list after deleting
      } else {
        throw Exception('Failed to delete gym');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
