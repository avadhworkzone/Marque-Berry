class NoteResModel {
  NoteResModel({
      this.status, 
      this.msg, 
      this.data,});

  NoteResModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? NoteData.fromJson(json['data']) : null;
  }
  int? status;
  String? msg;
  NoteData? data;

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

class NoteData {
  NoteData({
      this.id, 
      this.note, 
      this.videoUrl, 
      this.createdOn,});

  NoteData.fromJson(dynamic json) {
    id = json['id'];
    note = json['Note'];
    videoUrl = json['video_url'];
    createdOn = json['created_on'];
  }
  int? id;
  String? note;
  String? videoUrl;
  String? createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['Note'] = note;
    map['video_url'] = videoUrl;
    map['created_on'] = createdOn;
    return map;
  }

}