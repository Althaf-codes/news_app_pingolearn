import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/model/user_model.dart';
import 'package:news_app/service/user/user_service.dart';
import 'package:news_app/utils/exceptions/app_exception.dart';

class UserServiceImpl extends UserService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future createUser({
    required UserModel user,
    required String uid,
  }) async {
    await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .set(user.toMap(), SetOptions(merge: true));
  }

  @override
  Future<DocumentSnapshot> getUserByUid({required String uid}) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firebaseFirestore.collection('users').doc(uid).get();

      if (documentSnapshot.exists) {
        return documentSnapshot;
      } else {
        throw Exception('User Not Found');
      }
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Network Request time out');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
