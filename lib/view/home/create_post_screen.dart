import 'package:blog_management_app/controller/blog_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    final _contentController = TextEditingController();
    final _imageController = TextEditingController(); 
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
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
              controller: _imageController, 
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text;
                final content = _contentController.text;
                final imageUrl = _imageController.text; 

                await context
                    .read<BlogController>()
                    .createPost(title, content, imageUrl);
                Navigator.pop(context);
              },
              child: const Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}
