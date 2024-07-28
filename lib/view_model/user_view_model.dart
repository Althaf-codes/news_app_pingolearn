import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/model/user_model.dart';

import 'package:news_app/repository/user/user_repo.dart';
import 'package:news_app/repository/user/user_repo_impl.dart';

import 'package:news_app/utils/widgets/snackbar.dart';

class UserViewModel extends ChangeNotifier {
  UserModel? _userModel;
  final UserRepo _userRepo = UserRepoImpl();
  // final AuthRepo _authRepo = AuthRepoImpl();
  // final AuthService _authService = AuthServiceImpl();

  UserModel get user => _userModel ?? empty;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  static final empty = UserModel(
      name: '', preference: [], country: '', email: '', bookmarks: []);

  void setUser({required UserModel user}) {
    _userModel = user;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future createUser(
      {required UserModel usermodel,
      required String uid,
      required BuildContext context}) async {
    try {
      print('its coming here');
      await _userRepo.createUser(user: usermodel, uid: uid);
      _userModel = usermodel;
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        showErrorSnackBar(context, e.toString());
      }
    }
  }

  Future getUser({required String uid, required BuildContext context}) async {
    try {
      setLoading(true);
      UserModel userModel = await _userRepo.getUserByUid(uid: uid);
      _userModel = userModel;
      setLoading(false);

      // notifyListeners();
    } catch (e) {
      print("the error is ${e.toString()}");
      if (context.mounted) {
        showErrorSnackBar(context, e.toString());
      }
    }
  }
}
