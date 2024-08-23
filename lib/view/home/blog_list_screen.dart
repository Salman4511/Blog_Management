// ignore_for_file: use_build_context_synchronously

import 'package:blog_management_app/controller/auth_controller.dart';
import 'package:blog_management_app/controller/blog_controller.dart';
import 'package:blog_management_app/model/blog_post_model.dart';
import 'package:blog_management_app/widgets/blog_post_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Posts'),
        centerTitle: true,
        actions: [
          Consumer<AuthController>(
            builder: (context, value, child) => IconButton(
              onPressed: () async {
                await authController.logout();
                Navigator.pushNamed(context, '/login');
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ),
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<List<BlogPost>>(
        stream: context.read<BlogController>().getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final posts = snapshot.data ?? [];

          return posts.isEmpty
              ? const Center(
                  child: Text(
                    'No blog posts available.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      child: BlogPostTile(post: post),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createPost');
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
