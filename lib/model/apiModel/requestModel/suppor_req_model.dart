class SupportReqModel {
  SupportReqModel({
      this.fullName, 
      this.email, 
      this.message,});

  SupportReqModel.fromJson(dynamic json) {
    fullName = json['full_name'];
    email = json['email'];
    message = json['message'];
  }
  String? fullName;
  String? email;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['full_name'] = fullName;
    map['email'] = email;
    map['message'] = message;
    return map;
  }

}