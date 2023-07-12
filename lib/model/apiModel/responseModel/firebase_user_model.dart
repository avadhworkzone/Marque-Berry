class FirebaseUserModel {
  String? id;
  String? userName;
  String? fullName;
  String? userImage;
  String? deviceToken;
  int? updatedTime;

  FirebaseUserModel(
      {this.id,
      this.userName,
      this.fullName,
      this.userImage,
      this.deviceToken,
      this.updatedTime});

  FirebaseUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    fullName = json['fullName'];
    userImage = json['userImage'];
    deviceToken = json['deviceToken'];
    updatedTime = json['updatedTime'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "fullName": fullName,
        "userImage": userImage,
        "deviceToken": deviceToken,
        "updatedTime": updatedTime,
      };
}
