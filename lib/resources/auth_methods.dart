import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //singup

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    //required Uint8List file
  }) async {
    String res = "Some error occurred";
    try {
      // resgister user
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // add user to our database
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'username': username,
        'uid': cred.user!.uid,
        'email': email,
        'bio': bio,
        'followers': [],
        'following': []
      });
      res = "Success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
