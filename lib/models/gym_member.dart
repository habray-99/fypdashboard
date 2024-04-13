class GymMember {
  int? paymentId;
  String? paymentDate;
  int? memberId;
  int? gymId;
  int? months;
  String? tillwhen;
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
      this.memberImageUrl});

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
    return data;
  }
}

List<GymMember> gymMembersFromJson(List<dynamic> gymMembersJson) =>
    List<GymMember>.from(gymMembersJson
        .map((gymMemberJson) => GymMember.fromJson(gymMemberJson)));
