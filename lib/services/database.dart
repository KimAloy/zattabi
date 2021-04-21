import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:zattabi/controllers/controllers.dart';
import 'package:zattabi/models/models.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("Users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "userProfilePicture": user.userProfilePicture,
        "userPhoneNumber": user.userPhoneNumber,
        "joinedDate": user.joinedDate,
        "accountBalance": user.accountBalance,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateUser({
    String? uid,
    String? fullName,
    String? userPhoneNumber,
  }) async {
    final _controller = Get.put(UserController()).user;
    try {
      await _firestore.collection("Users").doc(uid).update({
        "name": fullName,
        "userPhoneNumber": userPhoneNumber,
        // "email": user.email,
        // "userProfilePicture": _user.userProfilePicture,
        // "joinedDate": user.joinedDate,
        // "accountBalance": user.accountBalance,
      }).then((value) {
        _controller.name = fullName;
        _controller.userPhoneNumber = userPhoneNumber;
        Get.back();
        print('User updated');
      });
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("Users").doc(uid).get();
      return UserModel.fromDocumentSnapShot(doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future deleteUser(String uid) async {
    return await _firestore.collection("Users").doc(uid).delete();
  }
}
