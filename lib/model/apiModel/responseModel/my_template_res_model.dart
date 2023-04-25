class MyTemplateResModel {
  int? status;
  String? msg;
  Data? data;

  MyTemplateResModel({this.status, this.msg, this.data});

  MyTemplateResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Standard>? standard;
  List<Standard>? licensed;

  Data({this.standard, this.licensed});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['standard'] != null) {
      standard = <Standard>[];
      json['standard'].forEach((v) {
        standard!.add(new Standard.fromJson(v));
      });
    }
    if (json['licensed'] != null) {
      licensed = <Standard>[];
      json['licensed'].forEach((v) {
        licensed!.add(new Standard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.standard != null) {
      data['standard'] = this.standard!.map((v) => v.toJson()).toList();
    }
    if (this.licensed != null) {
      data['licensed'] = this.licensed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Standard {
  int? id;
  String? userId;
  String? tag;
  String? templateUrl;
  String? status;
  String? createdOn;

  Standard(
      {this.id,
      this.userId,
      this.tag,
      this.templateUrl,
      this.status,
      this.createdOn});

  Standard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tag = json['tag'];
    templateUrl = json['template_url'];
    status = json['status'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['tag'] = this.tag;
    data['template_url'] = this.templateUrl;
    data['status'] = this.status;
    data['created_on'] = this.createdOn;
    return data;
  }
}

// class Licensed {
//   int? id;
//   String? userId;
//   String? tag;
//   String? templateUrl;
//   String? status;
//   String? createdOn;
//
//   Licensed(
//       {this.id,
//       this.userId,
//       this.tag,
//       this.templateUrl,
//       this.status,
//       this.createdOn});
//
//   Licensed.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     tag = json['tag'];
//     templateUrl = json['template_url'];
//     status = json['status'];
//     createdOn = json['created_on'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['tag'] = this.tag;
//     data['template_url'] = this.templateUrl;
//     data['status'] = this.status;
//     data['created_on'] = this.createdOn;
//     return data;
//   }
// }
