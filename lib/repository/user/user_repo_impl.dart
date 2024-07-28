import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/model/user_model.dart';
import 'package:news_app/repository/user/user_repo.dart';
import 'package:news_app/service/user/user_service.dart';
import 'package:news_app/service/user/user_service_impl.dart';

class UserRepoImpl extends UserRepo {
  final UserService _userService = UserServiceImpl();
  @override
  Future createUser({required UserModel user, required String uid}) async {
    await _userService.createUser(user: user, uid: uid);
  }

  @override
  Future<UserModel> getUserByUid({required String uid}) async {
    DocumentSnapshot snapshot = await _userService.getUserByUid(uid: uid);
    UserModel userModel = UserModel.fromDocument(snapshot);
    return userModel;
  }
}
