import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:insta_clone/models/user.dart' as model;
import 'package:insta_clone/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.UserModel.fromsnap(snap);
  }

  //singup

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = "Some error occurred";
    try {
      // resgister user
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String photoURL = await StorageMethods()
          .uploadImageToStorage('profilePics', file, false);
      // add user to our database

      model.UserModel user = model.UserModel(
          email: email,
          uid: cred.user!.uid,
          photUrl: photoURL,
          username: username,
          bio: bio,
          followers: [],
          following: []);

      await _firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(user.toJson());
      res = "Success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

// Login Auth
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Please enter all the details";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
