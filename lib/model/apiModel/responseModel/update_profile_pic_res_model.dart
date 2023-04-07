class UpdateProfilePicResModel {
  String? profilePic;

  UpdateProfilePicResModel({this.profilePic});

  UpdateProfilePicResModel.fromJson(Map<String, dynamic> json) {
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_pic'] = this.profilePic;
    return data;
  }
}
