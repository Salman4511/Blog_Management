import 'package:blog_management_app/controller/blog_controller.dart';
import 'package:blog_management_app/model/blog_post_model.dart';
import 'package:blog_management_app/widgets/blog_post_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blog Posts')),
      body: StreamBuilder<List<BlogPost>>(
        stream: context.read<BlogController>().getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final posts = snapshot.data ?? [];

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return BlogPostTile(post: post);
            },
          );
        },
      ),
    );
  }
}
