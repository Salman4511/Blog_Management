import 'package:blog_management_app/model/blog_post_model.dart';
import 'package:flutter/material.dart';

class BlogPostTile extends StatelessWidget {
  final BlogPost post;

  BlogPostTile({required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.content),
      leading: post.imageUrl != null ? Image.network(post.imageUrl!) : null,
      onTap: () {
        // Navigate to post details or edit page
      },
    );
  }
}
