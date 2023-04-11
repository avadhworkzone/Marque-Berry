import 'dart:convert';

class UserCategoryReqModel {
  List<String>? selectedCategoryIds;

  UserCategoryReqModel({this.selectedCategoryIds});

  UserCategoryReqModel.fromJson(Map<String, dynamic> json) {
    selectedCategoryIds = json['selected_category_ids'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selected_category_ids'] = jsonEncode(this.selectedCategoryIds ?? []);
    return data;
  }
}
