import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/util/constants.dart';
import 'dart:convert';

class Postrepository {
  String savePosturl = '/posts';
  String getPosturl = '/posts';
  String saveComment = '/comment';
  String getComment = '/comment/';

  Future savePost(content, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dynamic body = {
      "content": content,
      "images": images,
    };
    final response = await http.post(Uri.parse("$apiUrl$savePosturl"),
        body: jsonEncode(body),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        });
    return response;
  }

  Future getAllPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(Uri.parse("$apiUrl$getPosturl"), headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
    return response;
  }

  Future saveComments(postId, content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dynamic body = {
      "content": content,
      "postId": postId,
    };
    final response = await http.post(Uri.parse("$apiUrl$saveComment"),
        body: jsonEncode(body),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        });
    return response;
  }

  Future getAllPostComment(postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response =
        await http.get(Uri.parse("$apiUrl$getComment$postId"), headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
    return response;
  }

  Future<http.Response> postCommentLike(commentId, newStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      throw Exception('user is not authenticated');
    }
    final response = await http.put(
        Uri.parse("$apiUrl/comment/$commentId/like"),
        body: jsonEncode({'liked': newStatus}),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        });
    return response;
  }
}
