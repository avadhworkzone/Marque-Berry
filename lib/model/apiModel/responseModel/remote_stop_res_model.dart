class RemoteStopResModel {
  String? status;

  RemoteStopResModel({this.status});

  RemoteStopResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}
