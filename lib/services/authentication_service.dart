import 'package:compound/locator.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:compound/models/users.dart';

class AuthenticationService {
  User1 _currentUser;
  User1 get currentUser => _currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future _populateCurrentUser(User currentUser1) async {
    if (currentUser1 != null) {
      _currentUser = await _firestoreService.getUser(currentUser1.uid);
    }
  }

  Future loginWithEmail(
      {@required String email, @required String password}) async {
    try {
      var authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await _populateCurrentUser(authResult.user);
      return authResult != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpEmail(
      {@required String email,
      @required String password,
      @required String fullname,
      @required String roles}) async {
    try {
      var authresult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestoreService.createUser(User1(
        id: authresult.user.uid,
        fullName: fullname,
        email: email,
        userRole: roles,
      ));
      return authresult != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> alreadyLoggedIn() async {
    final User currentUser = auth.currentUser;
    await _populateCurrentUser(currentUser);
    return currentUser != null;
  }
}
