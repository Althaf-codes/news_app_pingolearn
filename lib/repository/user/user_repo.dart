import 'package:news_app/model/user_model.dart';

abstract class UserRepo {
  Future createUser({
    required UserModel user,
    required String uid,
  });

  Future<UserModel> getUserByUid({required String uid});
}
