import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compound/models/post.dart';
import 'package:compound/models/users.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _userColleectionRefrence =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference _postsColleectionRefrence =
      FirebaseFirestore.instance.collection("posts");

  final StreamController<List<Post>> _postData = StreamController<
      List<
          Post>>.broadcast(); //gets the stream for the Stream for the broadcast add into the _postdata

  Stream listenToPostRealtime() {
    _postsColleectionRefrence.snapshots().listen((postdata) {
      if (postdata.docs.isNotEmpty) {
        var posts = postdata.docs
            .map((post) => Post.fromMap(post.data()))
            .where((item) => item.title != null) //fucking arrow fcuntions
            .toList(); //querry snapshot is to be passed to the model for forMap() Map<String, dynamic>

        _postData.add(posts);//added the streams to the controller for the broadcast
      }
    });
  }

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

  Future getPostsOnceOff() async {
    try {
      var postDocuments = await _postsColleectionRefrence.limit(15).get();
      if (postDocuments.docs.isNotEmpty) {
        return postDocuments.docs
            .map((snapshot) => Post.fromMap(snapshot.data()))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
