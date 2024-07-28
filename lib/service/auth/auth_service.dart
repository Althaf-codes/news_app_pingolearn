import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User?> signInWithEmailPassword(
      {required String email, required String password});
  Future<User?> signUpUser({required String email, required String password});
  Future<void> resetPassword({required String email});
  Future<void> signOut();
}
