import 'package:socialv/model/apiModel/responseModel/category_res_model.dart';

class GetPostDetailResModel {
  GetPostDetailResModel({
      this.status, 
      this.msg, 
      this.data,});

  GetPostDetailResModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? CategoryData.fromJson(json['data']) : null;
  }
  int? status;
  String? msg;
  CategoryData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}
