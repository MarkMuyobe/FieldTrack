import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges =>  _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required email,
    required password,
  }) async{
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required email,
    required password,
  })async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password);
    } on FirebaseAuthException catch (e){
      String message = 'Whoo!';
      if (e.code == 'weak-password') {
        message = 'The password is too weak';
      }else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.green,
        fontSize: 14.0
      );

    }catch (e){}
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}