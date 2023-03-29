class FavouriteReqModel {
  String? token;
  String? idTag;

  FavouriteReqModel({this.token, this.idTag});

  FavouriteReqModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    idTag = json['idTag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['idTag'] = idTag;
    return data;
  }
}
