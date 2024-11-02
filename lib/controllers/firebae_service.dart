import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle Firebase auth errors
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
      }
      if (kDebugMode) {
        print(e.message);
      }
      return null;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      // Handle Firebase auth errors
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
      }
      if (kDebugMode) {
        print(e.message);
      }
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    try {
      await _auth.currentUser?.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      // Handle Firebase auth errors
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
      }
      if (kDebugMode) {
        print(e.message);
      }
    }
  }

  Future<void> createFirestoreDocument(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).set(data);
    } on FirebaseException catch (e) {
      // Handle Firestore errors
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
      }
      if (kDebugMode) {
        print(e.message);
      }
    }
  }
}