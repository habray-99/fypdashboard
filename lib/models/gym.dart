import 'package:fypdashboard/utils/storage_keys.dart';

class Gyms {
  int? gymId;
  String? gymName;
  String? gymAddress;
  String? gymPhone;
  String? gymEmail;
  String? gymPhotos;
  int? gymPrice;
  int? userID;

  Gyms({
    this.gymId,
    this.gymName,
    this.gymAddress,
    this.gymPhone,
    this.gymEmail,
    this.gymPhotos,
    this.gymPrice,
    this.userID,
  });

  factory Gyms.fromJson(Map<String, dynamic> json) {
    return Gyms(
      gymId: json['gym_id'],
      gymName: json['gym_name'],
      gymAddress: json['gym_address'],
      gymPhone: json['gym_phone'],
      gymEmail: json['gym_email'],
      gymPhotos: json['gym_photos'],
      gymPrice: json['gym_price'],
      userID: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gym_id': gymId,
      'gym_name': gymName,
      'gym_address': gymAddress,
      'gym_phone': gymPhone,
      'gym_email': gymEmail,
      'gym_photos': gymPhotos,
      'gym_price': gymPrice,
      'user_id': StorageHelper.getUserId(),
    };
  }
}

List<Gyms> gymDetailListFromJson(List<dynamic> gymDetailListJson) =>
    gymDetailListJson
        .map((gymDetailJson) =>
            Gyms.fromJson(gymDetailJson as Map<String, dynamic>))
        .toList();
