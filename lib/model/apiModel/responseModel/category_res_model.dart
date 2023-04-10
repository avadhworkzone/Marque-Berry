class CategoryResModel {
  int? postId;
  int? id;
  String? content;
  String? contentType;
  String? contentUrl;
  String? createdOn;
  int? noOfLikes;
  int? comments;
  List<LikedByPeople>? likedByPeople;
  bool? likedByMe;
  List<Author>? author;

  CategoryResModel({
    this.postId,
    this.id,
    this.content,
    this.contentType,
    this.contentUrl,
    this.createdOn,
    this.noOfLikes,
    this.likedByPeople,
    this.comments,
    this.likedByMe,
    this.author,
  });

  CategoryResModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    id = json['id'];
    content = json['content'];
    contentType = json['content_type'];
    contentUrl = json['content_url'];
    createdOn = json['created_on'];
    noOfLikes = json['noOfLikes'];
    comments = json['comments'];
    if (json['likedByPeople'] != null) {
      likedByPeople = <LikedByPeople>[];
      json['likedByPeople'].forEach((v) {
        likedByPeople!.add(new LikedByPeople.fromJson(v));
      });
    }
    likedByMe = json['likedByMe'];
    if (json['author'] != null) {
      author = <Author>[];
      json['author'].forEach((v) {
        author!.add(new Author.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['id'] = this.id;
    data['content'] = this.content;
    data['content_type'] = this.contentType;
    data['content_url'] = this.contentUrl;
    data['created_on'] = this.createdOn;
    data['noOfLikes'] = this.noOfLikes ?? 0;
    data['comments'] = this.comments ?? 0;
    if (this.likedByPeople != null) {
      data['likedByPeople'] =
          this.likedByPeople!.map((v) => v.toJson()).toList();
    }
    data['likedByMe'] = this.likedByMe;
    if (this.author != null) {
      data['author'] = this.author!.map((v) => v.toJson()).toList();
    }
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
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    return data;
  }
}
