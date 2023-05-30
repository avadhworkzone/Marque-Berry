class NoteResModel {
  NoteResModel({
    this.status,
    this.msg,
    this.data,
  });

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
    this.createdOn,
    this.thumbnail,
  });

  NoteData.fromJson(dynamic json) {
    id = json['id'];
    note = json['Note'];
    videoUrl = json['video_url'];
    createdOn = json['created_on'];
    thumbnail = json['thumbnail'];
  }
  int? id;
  String? note;
  String? videoUrl;
  String? createdOn;
  String? thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['Note'] = note;
    map['video_url'] = videoUrl;
    map['created_on'] = createdOn;
    map['thumbnail'] = thumbnail;
    return map;
  }
}
