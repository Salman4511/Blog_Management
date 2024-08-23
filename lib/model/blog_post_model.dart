import 'package:cloud_firestore/cloud_firestore.dart';

class BlogPost {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;
  final Timestamp createdAt;

  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.createdAt,
  });

  factory BlogPost.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BlogPost(
      id: doc.id,
      title: data['title'],
      content: data['content'],
      imageUrl: data['imageUrl'],
      createdAt: data['createdAt'],
    );
  }
}
