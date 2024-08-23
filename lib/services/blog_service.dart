import 'package:blog_management_app/model/blog_post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createPost(
      String title, String content, String? imageUrl) async {
    await _firestore.collection('posts').add({
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<List<BlogPost>> getPosts() {
    return _firestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return BlogPost.fromFirestore(doc);
      }).toList();
    });
  }

  Future<void> updatePost(String postId, Map<String, dynamic> data) async {
    await _firestore.collection('posts').doc(postId).update(data);
  }

  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }
}
