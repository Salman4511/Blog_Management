class UserModel {
  final String uid;
  final String email;
  final String? role;

  UserModel({
    required this.uid,
    required this.email,
    this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      role: data['role'],
    );
  }
}
