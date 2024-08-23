import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthController with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  Future<void> signUp(String email, String password) async {
    _user = await _authService.signUp(email, password);
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    _user = await _authService.signIn(email, password);
    notifyListeners();
  }
Future<void> logout() async {
    await _authService.logout();
    _user = null; 
    notifyListeners();
  }

}
