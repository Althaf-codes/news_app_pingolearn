import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/repository/auth/auth_repo.dart';
import 'package:news_app/service/auth/auth_service.dart';
import 'package:news_app/service/auth/auth_service_impl.dart';
import 'package:news_app/utils/exceptions/firebase_auth_exception.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthService _authService = AuthServiceImpl();

  @override
  Future<AuthResult> signInWithEmailPassword(
      {required String email, required String password}) async {
    AuthStatus status = AuthStatus.unknown;
    late AuthResult authResult;

    await _authService
        .signInWithEmailPassword(email: email, password: password)
        .then((val) {
      status = AuthStatus.successful;
      authResult = AuthResult(user: val, status: status);
      // return status;
    }).onError((e, _) {
      if (e.runtimeType == FirebaseAuthException) {
        e = e as FirebaseAuthException;

        print("its a firebase auth exception. the error ${e.code}");
        status = FirebaseAuthExceptionHandler.handleAuthException(
            e as FirebaseAuthException);
        authResult = AuthResult(user: null, status: status);
      } else if (e.runtimeType == SocketException) {
        status = AuthStatus.socketException;
        authResult = AuthResult(user: null, status: status);
      } else if (e.runtimeType == TimeoutException) {
        status = AuthStatus.timeOutException;
        authResult = AuthResult(user: null, status: status);
      }
    });
    return authResult;
  }

  @override
  Future<AuthResult> signUpUser(
      {required String email, required String password}) async {
    AuthStatus status = AuthStatus.unknown;
    late AuthResult authResult;

    await _authService.signUpUser(email: email, password: password).then((val) {
      status = AuthStatus.successful;
      authResult = AuthResult(user: val, status: status);
    }).onError((e, _) {
      if (e.runtimeType == FirebaseAuthException) {
        print("its a firebase auth exception");
        status = FirebaseAuthExceptionHandler.handleAuthException(
            e as FirebaseAuthException);
        authResult = AuthResult(user: null, status: status);
      } else if (e.runtimeType == SocketException) {
        status = AuthStatus.socketException;
        authResult = AuthResult(user: null, status: status);
      } else if (e.runtimeType == TimeoutException) {
        status = AuthStatus.timeOutException;
        authResult = AuthResult(user: null, status: status);
      }
    });
    return authResult;
  }

  @override
  Future<AuthStatus> signOut() async {
    AuthStatus status = AuthStatus.unknown;

    await _authService.signOut().then((val) {
      status = AuthStatus.successful;
      // return status;
    }).onError((e, _) {
      if (e.runtimeType == FirebaseAuthException) {
        print("its a firebase auth exception");
        status = FirebaseAuthExceptionHandler.handleAuthException(
            e as FirebaseAuthException);
        // return status;
      } else if (e.runtimeType == SocketException) {
        status = AuthStatus.socketException;
      } else if (e.runtimeType == TimeoutException) {
        status = AuthStatus.timeOutException;
      }
    });
    return status;
  }

  @override
  Future<AuthStatus> resetPassword({required String email}) async {
    AuthStatus status = AuthStatus.unknown;
    await _authService.resetPassword(email: email).then((val) {
      status = AuthStatus.successful;
      // return status;
    }).onError((e, _) {
      if (e.runtimeType == FirebaseAuthException) {
        print("its a firebase auth exception");
        status = FirebaseAuthExceptionHandler.handleAuthException(
            e as FirebaseAuthException);
        // return status;
      } else if (e.runtimeType == SocketException) {
        status = AuthStatus.socketException;
      } else if (e.runtimeType == TimeoutException) {
        status = AuthStatus.timeOutException;
      }
    });
    return status;
  }
}
