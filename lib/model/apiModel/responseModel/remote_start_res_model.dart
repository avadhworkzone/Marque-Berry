class RemoteStartResModel {
  String? status;

  RemoteStartResModel({this.status});

  RemoteStartResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}
