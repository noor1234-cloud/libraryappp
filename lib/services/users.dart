import'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
class UserServices{
///Create Users

  Future<void> createUser(UserModel model) async {
    await FirebaseFirestore.instance
        .collection('UserCollection')
        .add(model.toJson());
  }

  /// Get All Users
  Stream<List<UserModel>> getAllUsers() {
    return FirebaseFirestore.instance
        .collection('UserCollection')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList());
  }


  /// Update User
  Future<void> updateUser(UserModel model) async {
    await FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(model.docId)
        .update({
      "name": model.name,
      "email": model.email,
    });
  }

  /// Delete User
  Future<void> deleteUser(String userId) async {
    await FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(userId)
        .delete();
  }


}

