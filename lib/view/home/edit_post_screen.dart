import 'package:blog_management_app/controller/blog_controller.dart';
import 'package:blog_management_app/model/blog_post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPostScreen extends StatefulWidget {
  final BlogPost blogPost;

  const EditPostScreen({super.key, required this.blogPost});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.blogPost.title;
    _contentController.text = widget.blogPost.content;
    _imageUrlController.text = widget.blogPost.imageUrl ?? '';
  }

  Future<void> _updatePost() async {
    final title = _titleController.text;
    final content = _contentController.text;
    final imageUrl = _imageUrlController.text;

    await context.read<BlogController>().updatePost(widget.blogPost.id, {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updatePost,
              child: const Text('Update Post'),
            ),
          ],
        ),
      ),
    );
  }
}
