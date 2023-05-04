// class CampaignContestResModel {
//   int? status;
//   String? msg;
//   List<Campaign>? campaign;
//   List<Contest>? contest;
//
//   CampaignContestResModel({this.status, this.msg, this.campaign, this.contest});
//
//   CampaignContestResModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     msg = json['msg'];
//     if (json['campaign'] != null) {
//       campaign = <Campaign>[];
//       json['campaign'].forEach((v) {
//         campaign!.add(new Campaign.fromJson(v));
//       });
//     }
//     if (json['contest'] != null) {
//       contest = <Contest>[];
//       json['contest'].forEach((v) {
//         contest!.add(new Contest.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['msg'] = this.msg;
//     if (this.campaign != null) {
//       data['campaign'] = this.campaign!.map((v) => v.toJson()).toList();
//     }
//     if (this.contest != null) {
//       data['contest'] = this.contest!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Campaign {
//   int? id;
//   String? description;
//   String? image;
//   String? firstAward;
//   String? secondAward;
//   String? thirdAward;
//   String? createdOn;
//   String? applied;
//
//   Campaign({
//     this.id,
//     this.description,
//     this.image,
//     this.firstAward,
//     this.secondAward,
//     this.thirdAward,
//     this.createdOn,
//     this.applied,
//   });
//
//   Campaign.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     description = json['description'];
//     image = json['image'];
//     firstAward = json['first_award'];
//     secondAward = json['second_award'];
//     thirdAward = json['third_award'];
//     createdOn = json['created_on'];
//     applied = json['applied'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['description'] = this.description;
//     data['image'] = this.image;
//     data['first_award'] = this.firstAward;
//     data['second_award'] = this.secondAward;
//     data['third_award'] = this.thirdAward;
//     data['created_on'] = this.createdOn;
//     data['applied'] = this.applied ?? "false";
//     return data;
//   }
// }
//
// class Contest {
//   int? id;
//   String? description;
//   String? image;
//   String? firstAward;
//   String? secondAward;
//   String? thirdAward;
//   String? createdOn;
//   String? applied;
//
//   Contest(
//       {this.id,
//       this.description,
//       this.image,
//       this.firstAward,
//       this.secondAward,
//       this.thirdAward,
//       this.createdOn,
//       this.applied});
//
//   Contest.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     description = json['description'];
//     image = json['image'];
//     firstAward = json['first_award'];
//     secondAward = json['second_award'];
//     thirdAward = json['third_award'];
//     createdOn = json['created_on'];
//     applied = json['applied'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['description'] = this.description;
//     data['image'] = this.image;
//     data['first_award'] = this.firstAward;
//     data['second_award'] = this.secondAward;
//     data['third_award'] = this.thirdAward;
//     data['created_on'] = this.createdOn;
//     data['applied'] = this.applied ?? "false";
//     return data;
//   }
// }

class CampaignContestResModel {
  int? status;
  String? msg;
  List<Campaign>? campaign;
  List<Campaign>? contest;

  CampaignContestResModel({this.status, this.msg, this.campaign, this.contest});

  CampaignContestResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];

    if (json['campaign'] != null) {
      campaign = <Campaign>[];
      json['campaign'].forEach((v) {
        campaign!.add(new Campaign.fromJson(v));
      });
    }

    if (json['contest'] != null) {
      contest = <Campaign>[];
      json['contest'].forEach((v) {
        contest!.add(new Campaign.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;

    if (this.campaign != null) {
      data['campaign'] = this.campaign!.map((v) => v.toJson()).toList();
    }

    if (this.contest != null) {
      data['contest'] = this.contest!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Campaign {
  int? id;
  String? userId;
  String? brandName;
  String? campaignName;
  String? logo;
  String? timeLimit;
  String? description;
  String? status;
  String? staticMeme;
  String? videoMeme;
  String? gif;
  String? noOfMemeNeeded;
  String? createdOn;
  String? applied;

  Campaign({
    this.id,
    this.userId,
    this.brandName,
    this.campaignName,
    this.logo,
    this.timeLimit,
    this.description,
    this.status,
    this.staticMeme,
    this.videoMeme,
    this.gif,
    this.noOfMemeNeeded,
    this.createdOn,
    this.applied,
  });

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    brandName = json['brand_name'] ?? "";
    campaignName = json['campaign_name'] ?? "";
    logo = json['logo'] ?? "";
    timeLimit = json['time_limit'] ?? "";
    description = json['description'] ?? "";
    status = json['status'] ?? "";
    staticMeme = json['static_meme'] ?? "";
    videoMeme = json['video_meme'] ?? "";
    gif = json['gif'] == null ? "" : json['gif'];
    noOfMemeNeeded = json['no_of_meme_needed'] ?? "";
    createdOn = json['created_on'] ?? "";
    applied = json['applied'] ?? "false";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['brand_name'] = this.brandName;
    data['campaign_name'] = this.campaignName;
    data['logo'] = this.logo;
    data['time_limit'] = this.timeLimit;
    data['description'] = this.description;
    data['status'] = this.status;
    data['static_meme'] = this.staticMeme;
    data['video_meme'] = this.videoMeme;
    data['gif'] = this.gif;
    data['no_of_meme_needed'] = this.noOfMemeNeeded;
    data['created_on'] = this.createdOn;
    data['applied'] = this.applied;
    return data;
  }
}
