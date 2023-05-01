class DeleteFollowReqModel {
  String? id;
  String? flag;

  DeleteFollowReqModel({this.id, this.flag});

  DeleteFollowReqModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flag'] = this.flag;
    return data;
  }
}
