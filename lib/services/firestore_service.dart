import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compound/models/post.dart';
import 'package:compound/models/users.dart';

class FirestoreService {
  final CollectionReference _userColleectionRefrence =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference _postsColleectionRefrence =
      FirebaseFirestore.instance.collection("posts");

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

  Future addPost(Post post) async {
    try {
      await _postsColleectionRefrence.add(post.toMap());
      return true;
    } catch (e) {
      e.toString();
    }
  }

  Future getPostsOnceOff(Post post)async 
  {
    try
    {
      

    }catch(e)
    {

    }
  }
}
