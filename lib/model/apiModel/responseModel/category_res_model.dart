class CategoryResModel {
  int? status;
  String? msg;
  List<CategoryData>? data;

  CategoryResModel({this.status, this.msg, this.data});

  CategoryResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  int? id;
  String? userId;
  String? content;
  String? username;
  String? image;
  bool? followedByMe;
  String? contentType;
  String? contentUrl;
  String? categoryId;
  String? createdOn;
  int? comments;
  List<Author>? author;
  List<LikedByPeople>? likedByPeople;
  List<TagUser>? tagUser;
  bool? likedByMe;

  CategoryData(
      {this.id,
      this.userId,
      this.content,
      this.image,
      this.username,
      this.followedByMe,
      this.contentType,
      this.contentUrl,
      this.categoryId,
      this.createdOn,
      this.comments,
      this.author,
      this.likedByPeople,
      this.likedByMe,
      this.tagUser});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    content = json['content'];
    username = json['username'];
    image = json['image'];
    followedByMe = json['followedByMe'] ?? false;
    contentType = json['content_type'];
    contentUrl = json['content_url'];
    categoryId = json['category_id'];
    createdOn = json['created_on'];
    comments = json['comments'];
    if (json['author'] != null) {
      author = <Author>[];
      json['author'].forEach((v) {
        author!.add(new Author.fromJson(v));
      });
    }
    if (json['tag_user'] != null) {
      tagUser = <TagUser>[];
      json['tag_user'].forEach((v) {
        tagUser!.add(new TagUser.fromJson(v));
      });
    }
    if (json['likedByPeople'] != null) {
      likedByPeople = <LikedByPeople>[];
      json['likedByPeople'].forEach((v) {
        likedByPeople!.add(new LikedByPeople.fromJson(v));
      });
    }
    likedByMe = json['likedByMe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['username'] = this.username;
    data['image'] = this.image;
    data['followedByMe'] = this.followedByMe;
    data['username'] = this.username;
    data['content_type'] = this.contentType;
    data['content_url'] = this.contentUrl;
    data['category_id'] = this.categoryId;
    data['created_on'] = this.createdOn ?? "";
    data['comments'] = this.comments;
    if (this.author != null) {
      data['author'] = this.author!.map((v) => v.toJson()).toList();
    }
    if (this.tagUser != null) {
      data['tag_user'] = this.tagUser!.map((v) => v.toJson()).toList();
    }
    if (this.likedByPeople != null) {
      data['likedByPeople'] =
          this.likedByPeople!.map((v) => v.toJson()).toList();
    }
    data['likedByMe'] = this.likedByMe;
    return data;
  }
}

class TagUser {
  int? id;
  String? username;
  String? fullName;
  String? image;

  TagUser({this.id, this.username, this.fullName,this.image});

  TagUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    return data;
  }
}

class Author {
  int? id;
  String? username;
  String? fullName;
  String? image;

  Author({this.id, this.username, this.fullName, this.image});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username ?? "";
    data['full_name'] = this.fullName ?? "";
    data['image'] = this.image ?? "";
    return data;
  }
}

class LikedByPeople {
  int? id;
  String? username;
  String? fullName;
  String? image;

  LikedByPeople({this.id, this.username, this.fullName, this.image});

  LikedByPeople.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    return data;
  }
}
