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
      appBar: AppBar(title: const Text('Blog Posts'),actions:[ 
       Consumer<AuthController>(
              builder:(context, value, child) =>IconButton(
                  onPressed: () async{
                  await authController.logout();
                  Navigator.pushNamed(context, '/login');
                  },
                  icon: const Icon(Icons.logout_outlined)),
            ),
      ]),
      body: StreamBuilder<List<BlogPost>>(
        stream: context.read<BlogController>().getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
