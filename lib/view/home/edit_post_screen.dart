// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:blog_management_app/controller/blog_controller.dart';
import 'package:blog_management_app/model/blog_post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class EditPostScreen extends StatelessWidget {
  final BlogPost blogPost;

  const EditPostScreen({super.key, required this.blogPost});

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController(text: blogPost.title);
    final _contentController = TextEditingController(text: blogPost.content);

    void _pickImage() async {
      await context.read<BlogController>().pickImage();
    }

    Future<void> _updatePost() async {
      final title = _titleController.text;
      final content = _contentController.text;
      final imageUrl = context.read<BlogController>().image?.path;

      await context.read<BlogController>().updatePost(blogPost.id, {
        'title': title,
        'content': content,
        'imageUrl': imageUrl,
      });

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Consumer<BlogController>(
            builder: (context, blogController, child) {
              final selectedImage = blogController.image;

              return Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextFormField(
                    controller: _contentController,
                    decoration: const InputDecoration(labelText: 'Content'),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[300],
                        image: selectedImage != null
                            ? DecorationImage(
                                image: FileImage(selectedImage),
                                fit: BoxFit.cover,
                              )
                            : (blogPost.imageUrl != null
                                ? DecorationImage(
                                    image: FileImage(File(blogPost.imageUrl!)),
                                    fit: BoxFit.cover,
                                  )
                                : null),
                      ),
                      child: selectedImage == null && blogPost.imageUrl == null
                          ? const Center(
                              child: Icon(Icons.add_a_photo,
                                  size: 50, color: Colors.grey))
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updatePost,
                    child: const Text('Update Post'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
