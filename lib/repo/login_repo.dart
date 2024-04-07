import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/user_details.dart';
import '../utils/apis.dart';

class LoginRepo {
  static Future<void> login({
    required String email,
    required String password,
    required Function(UserDetail user, String token) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var header = {
        "Accept": "application/json",
      };
      var body = {
        "email": email,
        "password": password,
        "type": "customer",
      };
      http.Response response = await http.post(
        Uri.parse(Apis.loginUrl),
        headers: header,
        body: body,
      );
      dynamic data = jsonDecode(response.body);
      if (response.statusCode == 200 && response.statusCode < 300) {
        String token = data["Token"].toString();
        UserDetail user = UserDetail.fromJson(data["member"]);
        onSuccess(user, token);
      } else {
        onError(data["message"].toString());
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Something went wrong");
    }
  }
}
