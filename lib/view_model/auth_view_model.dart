import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/service/auth/auth_service.dart';
import 'package:news_app/service/auth/auth_service_impl.dart';
import 'package:news_app/utils/widgets/snackbar.dart';

class AuthViewModel with ChangeNotifier {
  AuthService _authService = AuthServiceImpl();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future signOut() async {
    await _authService.signOut();
  }

  Future resetPassword(
      {required String email, required BuildContext context}) async {
    await _authService.resetPassword(email: email).then((val) {
      showSnackBar(context, "Reset link has been sent to your email");
    }).onError((e, _) {
      showErrorSnackBar(context, e.toString());
    });
  }
}
