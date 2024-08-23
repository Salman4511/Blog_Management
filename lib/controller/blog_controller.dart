import 'dart:io';

import 'package:blog_management_app/model/blog_post_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/blog_service.dart';

class BlogController with ChangeNotifier {
  final BlogService _blogService = BlogService();
  File? _image;
  File? get image => _image;

  final ImagePicker _picker = ImagePicker();

  Stream<List<BlogPost>> getPosts() {
    return _blogService.getPosts();
  }

  Future<void> createPost(
      String title, String content, String? imageUrl) async {
    await _blogService.createPost(title, content, imageUrl);
  }

  Future<void> updatePost(String postId, Map<String, dynamic> data) async {
    await _blogService.updatePost(postId, data);
  }

  Future<void> deletePost(String postId) async {
    await _blogService.deletePost(postId);
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

  void clearImage() {
    _image = null;
    notifyListeners();
  }
}
