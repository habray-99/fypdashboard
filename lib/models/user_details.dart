class UserDetail {
  int? memberId;
  String? memberName;
  String? memberEmail;
  String? memberPhone;
  String? memberAddress;
  int? memberType;
  Null memberImageUrl;

  UserDetail(
      {this.memberId,
      this.memberName,
      this.memberEmail,
      this.memberPhone,
      this.memberAddress,
      this.memberType,
      this.memberImageUrl});

  UserDetail.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    memberName = json['member_name'];
    memberEmail = json['member_email'];
    memberPhone = json['member_phone'];
    memberAddress = json['member_address'];
    memberType = json['member_type'];
    memberImageUrl = json['member_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['member_id'] = memberId;
    data['member_name'] = memberName;
    data['member_email'] = memberEmail;
    data['member_phone'] = memberPhone;
    data['member_address'] = memberAddress;
    data['member_type'] = memberType;
    data['member_image_url'] = memberImageUrl;
    return data;
  }
}
