class PostModel {
  String? sId;
  String? content;
  List<String>? images;
  CreatedBy? createdBy;
  String? createdAt;
  int? iV;

  PostModel(
      {this.sId,
      this.content,
      this.images,
      this.createdBy,
      this.createdAt,
      this.iV});

  PostModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    images = json['images'].cast<String>();
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['content'] = content;
    data['images'] = images;
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
    }
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}

class CreatedBy {
  String? sId;
  String? username;
  String? email;

  CreatedBy({this.sId, this.username, this.email});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    return data;
  }
}
