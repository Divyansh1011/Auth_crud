import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compound/models/users.dart';

class FirestoreService {
  final CollectionReference _userColleectionRefrence =
      FirebaseFirestore.instance.collection("users");

  Future createUser(User1 user) async {
    try {
      await _userColleectionRefrence.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userdata = await _userColleectionRefrence.doc(uid).get();
      return User1.fromData(userdata.data());
    } catch (e) {
      return e.message;
    }
  }
}
