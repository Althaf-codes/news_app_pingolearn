import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/utils/exceptions/firebase_auth_exception.dart';

abstract class AuthRepo {
  Future<AuthResult> signInWithEmailPassword(
      {required String email, required String password});
  Future<AuthResult> signUpUser(
      {required String email, required String password});
  Future<AuthStatus> resetPassword({required String email});

  Future<AuthStatus> signOut();
}

class AuthResult {
  final User? user;
  final AuthStatus status;

  AuthResult({required this.user, required this.status});
}
