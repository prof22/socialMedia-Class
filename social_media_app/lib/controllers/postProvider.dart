import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/commentModel.dart';
import 'package:social_media_app/models/postModel.dart';
import 'package:social_media_app/repo/postRepository.dart';

class PostProvider extends ChangeNotifier {
  PostProvider() {
    fetchAllPosts();
  }
  final Postrepository _postrepository = Postrepository();
  String _postText = '';
  String get postText => _postText;

  void setPostText(String text) {
    _postText = text;
    notifyListeners();
  }

  List<File> _pickImages = [];
  List<File> get pickImages => _pickImages;

  void addImage(File image) {
    _pickImages.add(image);
    notifyListeners();
  }

  void removeImage(File image) {
    _pickImages.remove(image);
    notifyListeners();
  }

  void clearImage() {
    _pickImages.clear();
    notifyListeners();
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
      allowMultiple: true,
    );
    if (result != null) {
      _pickImages = result.files
          .where((file) => file.path != null)
          .map((file) => File(file.path!))
          .toList();
      notifyListeners();
    }
  }

  final cloudinary = CloudinaryPublic("dlp2j8kgs", "hnms4mow");
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> savePost() async {
    _isLoading = true;
    notifyListeners();

    List<String> imageUrl = [];
    try {
      List<CloudinaryResponse> imageResponses = await cloudinary.uploadFiles(
          _pickImages
              .map((imageFiles) =>
                  CloudinaryFile.fromFile(imageFiles.path, folder: 'post'))
              .toList());

      for (var imageResponse in imageResponses) {
        imageUrl.add(imageResponse.secureUrl);
      }
      final response = await _postrepository.savePost(postText, imageUrl);
      _isLoading = false;
      notifyListeners();
      return response.statusCode == 201;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  List<PostModel> _posts = [];
  bool _isPostLoading = false;
  String? _errors;

  List<PostModel> get posts => _posts;
  bool get isPostLoading => _isPostLoading;
  String? get errors => _errors;

  Future<void> fetchAllPosts() async {
    _isPostLoading = true;
    _errors = null;
    notifyListeners();

    try {
      final response = await _postrepository.getAllPost();
      if (response.statusCode == 200) {
        final List<dynamic> postJson = json.decode(response.body)['posts'];

        _posts = postJson.map((json) => PostModel.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('failed to load post');
      }
    } catch (e) {
      _errors = e.toString();
      _posts = [];
      _isPostLoading = false;
      notifyListeners();
    } finally {
      _isPostLoading = false;
      notifyListeners();
    }
  }

  //Comments

  List<CommentModel>? _comments = [];

  String? _errorComments;

  List<CommentModel>? get comments => _comments;

  String? get errorComments => _errorComments;

  bool _isGetCommentLoading = false;
  bool get isGetCommentLoading => _isGetCommentLoading;

  Map<String, int> commentsCounts = {};

  Future<List<CommentModel>?> fetchAllComments(postId) async {
    try {
      _isGetCommentLoading = true;
      notifyListeners();

      final response = await _postrepository.getAllPostComment(postId);
      if (response.statusCode == 200) {
        final List<dynamic> commentPost =
            json.decode(response.body)['comments'];
        _comments =
            commentPost.map((json) => CommentModel.fromJson(json)).toList();
        commentsCounts[postId] = _comments!.length;
        _isGetCommentLoading = false;
        notifyListeners();
        return _comments;
      } else if (response.statusCode == 401) {
        //logout user out
      } else {
        _isGetCommentLoading = false;
        notifyListeners();
        throw Exception('Failed to load comments');
      }
      return null;
    } catch (e) {
      _errorComments = e.toString();
      _isGetCommentLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<List<CommentModel>?> fetchAllRecentComment(postId) async {
    try {
      _isGetCommentLoading = true;
      notifyListeners();

      final response = await _postrepository.getAllPostComment(postId);
      if (response.statusCode == 200) {
        final List<dynamic> commentPost =
            json.decode(response.body)['comments'];
        _comments =
            commentPost.map((json) => CommentModel.fromJson(json)).toList();
        _comments!
            .sort((a, b) => b.createdAt!.compareTo(a.createdAt.toString()));

        _isGetCommentLoading = false;
        notifyListeners();
        return _comments;
      } else if (response.statusCode == 401) {
        //logout user out
      } else {
        _isGetCommentLoading = false;
        notifyListeners();
        throw Exception('Failed to load comments');
      }
      return null;
    } catch (e) {
      _errorComments = e.toString();
      _isGetCommentLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<List<CommentModel>?> fetchAllCommentsWithReloading(postId) async {
    try {
      final response = await _postrepository.getAllPostComment(postId);
      if (response.statusCode == 200) {
        final List<dynamic> commentPost =
            json.decode(response.body)['comments'];
        _comments =
            commentPost.map((json) => CommentModel.fromJson(json)).toList();
        commentsCounts[postId] = _comments!.length;
        notifyListeners();
        return _comments;
      } else if (response.statusCode == 401) {
        //logout user out
      } else {
        notifyListeners();
        throw Exception('Failed to load comments');
      }
      return null;
    } catch (e) {
      _errorComments = e.toString();
      notifyListeners();
      return null;
    }
  }

  bool _isCommentloading = false;
  bool get isCommentLoading => _isCommentloading;

  Future<bool> saveComment(content, postId) async {
    _isCommentloading = true;
    notifyListeners();
    try {
      final response = await _postrepository.saveComments(postId, content);
      if (response.statusCode == 201) {
        _comments = await fetchAllComments(postId);
        _isCommentloading = false;
        notifyListeners();
        return true;
      }
      _isCommentloading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _isCommentloading = false;
      notifyListeners();
      return false;
    }
  }

  Map<String, bool> likedComments = {};

  bool isCommentLiked(String commentId) {
    return likedComments[commentId] ?? false;
  }

  Future<void> toggleCommentLike(String commentId, postId) async {
    bool isLiked = likedComments[commentId] ?? false;
    bool newStatus = !isLiked;
    likedComments[commentId] = newStatus;
    notifyListeners();

    try {
      final response =
          await _postrepository.postCommentLike(commentId, newStatus);
      if (response.statusCode == 200) {
        await fetchAllCommentsWithReloading(postId);
      } else {
        likedComments[commentId] = isLiked;
        notifyListeners();
      }
    } catch (e) {
      likedComments[commentId] = isLiked;
      notifyListeners();
    }
  }
}
