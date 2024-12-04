class CommentModel {
  String? sId;
  String? content;
  String? postId;
  CreatedBy? createdBy;
  List<String>? likes;
  String? createdAt;
  int? iV;

  CommentModel(
      {this.sId,
      this.content,
      this.postId,
      this.createdBy,
      this.likes,
      this.createdAt,
      this.iV});

  CommentModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    postId = json['postId'];
    createdBy = json['createdBy'] != null
        ? CreatedBy.fromJson(json['createdBy'])
        : null;
    likes = json['likes'].cast<String>();
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['content'] = content;
    data['postId'] = postId;
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
    }
    data['likes'] = likes;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}

class CreatedBy {
  String? sId;
  String? username;

  CreatedBy({this.sId, this.username});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    return data;
  }
}
