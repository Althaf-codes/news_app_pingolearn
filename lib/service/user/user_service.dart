import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/model/user_model.dart';

abstract class UserService {
  Future createUser({
    required UserModel user,
    required String uid,
  });

  Future<DocumentSnapshot> getUserByUid({required String uid});
}
