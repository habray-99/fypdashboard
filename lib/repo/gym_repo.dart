// import 'dart:convert';
// import 'dart:developer';

// import 'package:fypdashboard/models/gym_member.dart';
// import 'package:http/http.dart' as http;

// import '../utils/apis.dart';

// class GetGymMembersRepo {
//   static Future<void> getGymMembers({
//     required List<int> gymId,
//     required Function(List<GymMember> exerciseRecommendation) onSuccess,
//     required Function(String message) onError,
//   }) async {
//     try {
//       var header = {
//         "Accept": "application/json",
//         "Content-Type": "application/json",
//       };

//       // Construct the URL with query5 parameters
//       var url = Uri.parse(Apis.fetchAllMemberByGym);

//       // log(url.toString());

//       var response = await http.post(url, headers: header, body: jsonEncode(gymId));
//       // var response = await HttpRequest.get(url, headers: header);
//       // print("Response: ");
//       // log(response.toString());
//       dynamic data = jsonDecode(response.body);
//       if (response.statusCode >= 200 &&
//           data['message'] == "Payments fetched successfully") {
//         List<GymMember> recommendations = gymMembersFromJson(data["payments"]);
//         onSuccess(recommendations);
//       } else {
//         onError(data["message"].toString());
//       }
//     } catch (e, s) {
//       log(e.toString());
//       log(s.toString());
//       onError("Something went wrong.");
//     }
//   }
import 'dart:convert';
import 'dart:developer';

import 'package:fypdashboard/models/gym_member.dart';
import 'package:http/http.dart' as http;

import '../utils/apis.dart';

class GetGymMembersRepo {
  static Future<void> getGymMembers({
    required int? gymId,
    required Function(List<GymMember> exerciseRecommendation) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var header = {
        "Accept": "application/json",
        // "Content-Type": "application/json",
      };

      // Construct the URL
      var url = Uri.parse(Apis.fetchAllMemberByGym).replace(queryParameters: {
        "gym_id": gymId.toString(),
      });

      // Prepare the body of the request as a JSON string
      // var body = jsonEncode({'gym_ids': gymId});

      var response = await http.get(
        url,
        headers: header,
      );
      dynamic data = jsonDecode(response.body);
      log(data.toString());
      if (data['message'] == "Members fetched successfully") {
        List<GymMember> recommendations = gymMembersFromJson(data["members"]);
        onSuccess(recommendations);
      } else {
        onError(data["Members"].toString());
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Something went wrong.");
    }
  }

  static Future<void> getAllGymMembers({
    required Function(List<GymMember> exerciseRecommendation) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var header = {
        "Accept": "application/json",
      };

      var response =
          await http.get(Uri.parse(Apis.allMembers), headers: header);
      dynamic data = jsonDecode(response.body);
      if (response.statusCode >= 200 &&
          data['message'] == "Users fetched successfully") {
        List<GymMember> members = gymMembersFromJson(data["users"]);
        log(members.toString());
        onSuccess(members);
      } else {
        onError(data["message"].toString());
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Something went wrong.");
    }
  }

  static Future<void> getAllGymMemberShips({
    required Function(List<GymMember> exerciseRecommendation) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var header = {
        "Accept": "application/json",
      };
      var response =
          await http.get(Uri.parse(Apis.allPayments), headers: header);
      dynamic data = jsonDecode(response.body);
      if (response.statusCode >= 200 &&
          data['message'] == "Payments fetched successfully") {
        List<GymMember> members = gymMembersFromJson(data["payments"]);
        log(members.toString());
        onSuccess(members);
      } else {
        onError(data["message"].toString());
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Something went wrong.");
    }
  }

  static Future<void> addGymMember(
      {required GymMember member,
      required Function(dynamic message) onSuccess,
      required Function(dynamic message) onError}) async {
    var header = {
      "Accept": "application/json",
    };

    var body = member.toJson();

    var response =
        await http.post(Uri.parse(Apis.baseUrl), headers: header, body: body);

    dynamic data = jsonDecode(response.body);
    if (data["status"] == "success") {
      onSuccess(data["message"]);
    } else {
      onError(data["message"]);
    }
  }
}
