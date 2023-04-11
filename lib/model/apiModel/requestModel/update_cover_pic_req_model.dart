class UpdateCoverPicReqModel {
  String? coverPhoto;

  UpdateCoverPicReqModel({this.coverPhoto});

  UpdateCoverPicReqModel.fromJson(Map<String, dynamic> json) {
    coverPhoto = json['cover_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover_photo'] = this.coverPhoto;
    return data;
  }
}
