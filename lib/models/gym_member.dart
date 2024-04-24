class GymMember {
  int? paymentId;
  String? paymentDate;
  int? memberId;
  int? gymId;
  int? months;
  String? tillwhen;
  String? fromWhen;
  int? isValid;
  String? memberName;
  String? memberEmail;
  String? memberPhone;
  String? memberAddress;
  String? memberHeight;
  String? memberPassword;
  String? memberWeight;
  int? memberType;
  Null memberImageUrl;
  String? gymName;
  String? gymAddress;
  String? gymPhone;
  String? gymEmail;
  String? gymPhotos;
  int? gymPrice;
  int? ownerId;

  GymMember(
      {this.paymentId,
      this.paymentDate,
      this.memberId,
      this.gymId,
      this.months,
      this.tillwhen,
      this.isValid,
      this.memberName,
      this.memberEmail,
      this.memberPhone,
      this.memberAddress,
      this.memberHeight,
      this.memberWeight,
      this.memberType,
      this.memberPassword,
      this.fromWhen,
      this.memberImageUrl,
      this.gymName,
      this.gymAddress,
      this.gymPhone,
      this.gymEmail,
      this.gymPhotos,
      this.gymPrice,
      this.ownerId});

  GymMember.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    paymentDate = json['payment_date'];
    memberId = json['member_id'];
    gymId = json['gym_id'];
    months = json['months'];
    tillwhen = json['tillwhen'];
    isValid = json['is_valid'];
    memberName = json['member_name'];
    memberEmail = json['member_email'];
    memberPhone = json['member_phone'];
    memberAddress = json['member_address'];
    memberHeight = json['member_height'];
    memberWeight = json['member_weight'];
    memberType = json['member_type'];
    memberImageUrl = json['member_image_url'];
    gymName = json['gym_name'];
    gymAddress = json['gym_address'];
    gymPhone = json['gym_phone'];
    gymEmail = json['gym_email'];
    gymPhotos = json['gym_photos'];
    gymPrice = json['gym_price'];
    ownerId = json['owner_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_id'] = paymentId;
    data['payment_date'] = paymentDate;
    data['member_id'] = memberId;
    data['gym_id'] = gymId;
    data['months'] = months;
    data['tillwhen'] = tillwhen;
    data['is_valid'] = isValid;
    data['member_name'] = memberName;
    data['member_email'] = memberEmail;
    data['member_phone'] = memberPhone;
    data['member_address'] = memberAddress;
    data['member_height'] = memberHeight;
    data['member_weight'] = memberWeight;
    data['member_type'] = memberType;
    data['member_image_url'] = memberImageUrl;
    data['fromWhen'] = fromWhen;
    data['member_image_url'] = memberImageUrl;
    data['gym_name'] = gymName;
    data['gym_address'] = gymAddress;
    data['gym_phone'] = gymPhone;
    data['gym_email'] = gymEmail;
    data['gym_photos'] = gymPhotos;
    data['gym_price'] = gymPrice;
    data['owner_id'] = ownerId;
    return data;
  }
}

List<GymMember> gymMembersFromJson(List<dynamic> gymMembersJson) =>
    List<GymMember>.from(gymMembersJson
        .map((gymMemberJson) => GymMember.fromJson(gymMemberJson)));
