import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String email;
  final String uid;
  final String photUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const UserModel({
    required this.email,
    required this.uid,
    required this.photUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "photoUrl": photUrl,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": followers
      };

  static UserModel fromsnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);

    return UserModel(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photUrl: snapshot['photoUrl'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
