import 'package:flutter/material.dart';

class Expandedtextprovider extends ChangeNotifier {
  final _isExpanded = <String, bool>{};
  bool isExpanded(String postId) {
    return _isExpanded[postId] ?? false;
  }

  void toggleExpanded(String postId) {
    _isExpanded[postId] = !(isExpanded(postId));
    notifyListeners();
  }
}
