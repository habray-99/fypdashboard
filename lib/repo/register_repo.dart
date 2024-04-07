// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;

// import '../utils/apis.dart';

// class RegisterRepo {
//   static Future<void> register({
//     required String email,
//     required String name,
//     required String phoneNumber,
//     required String password,
//     required Function(String successMessage) onSuccess,
//     required Function(String message) onError,
//   }) async {
//     try {
//       var header = {
//         "Accept": "application/json",
//       };
//       var body = {
//         "name": name,
//         "email": email,
//         "phone": phoneNumber,
//         "password": password,
//         "type": "customer"
//       };
//       http.Response response = await http.post(
//         Uri.parse(Apis.registerUrl),
//         headers: header,
//         body: body,
//       );
//       log(body.toString());
//       log(Apis.registerUrl);
//       dynamic data = jsonDecode(response.body.toString());
//       // log(data.toString());
//       if (response.statusCode >= 200 && response.statusCode <= 300) {
//         onSuccess(data["message"]);
//       } else {
//         onError(data["message"]);
//       }
//     } catch (e, s) {
//       log(e.toString());
//       log(s.toString());
//       onError("Something went wrong");
//     }
//   }
// }
