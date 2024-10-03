import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<DocumentSnapshot>? _userListener;
  List<User> _allUsers = [];

  User? get user => _user;
  UserRole get userRole => _user?.role ?? UserRole.user;
  List<User> get allUsers => _allUsers;

  firebase_auth.User? get currentUser => _auth.currentUser;
  Stream<firebase_auth.User?> get authStateChanges => _auth.authStateChanges();

  Future<void> initializeUser() async {
    final firebase_auth.User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      await _fetchUserData(firebaseUser.uid);
      startListeningToUserChanges();
    }
  }

  Future<void> _fetchUserData(String uid) async {
    try {
      final userData = await _firestore.collection('users').doc(uid).get();
      if (userData.exists) {
        _user = User.fromJson(userData.data()!);
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _fetchUserData(userCredential.user!.uid);
      startListeningToUserChanges();
    } catch (e) {
      print('Error signing in: $e');
      rethrow;
    }
  }

  Future<void> signUp(User newUser, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: newUser.email, password: password);
      newUser.uid = userCredential.user!.uid;
      await _firestore.collection('users').doc(newUser.uid).set(newUser.toJson());
      _user = newUser;
      notifyListeners();
    } on firebase_auth.FirebaseAuthException catch (e) {
      String message = 'An error occurred during sign up.';
      if (e.code == 'weak-password') {
        message = 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
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
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _user = null;
      _userListener?.cancel();
      notifyListeners();
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }

  Future<void> updateUser(User updatedUser) async {
    try {
      await _firestore.collection('users').doc(updatedUser.uid).update(updatedUser.toJson());
      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  bool hasRole(UserRole role) {
    return _user?.role == role;
  }

  bool hasAtLeastRole(UserRole minimumRole) {
    if (_user == null) return false;
    return _user!.role.index >= minimumRole.index;
  }

  void startListeningToUserChanges() {
    final String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      _userListener = _firestore.collection('users').doc(uid).snapshots().listen((docSnapshot) {
        if (docSnapshot.exists) {
          try {
            _user = User.fromJson(docSnapshot.data()!);
            notifyListeners();
          } catch (e) {
            print('Error parsing user data: $e');
            // Set _user to a default user with 'user' role
            _user = User(
              uid: uid,
              firstName: '',
              surname: '',
              email: _auth.currentUser?.email ?? '',
              phoneNumber: '',
              role: UserRole.user
            );
            notifyListeners();
          }
        } else {
          print('User document does not exist');
          // Create a default user document if it doesn't exist
          _user = User(
            uid: uid,
            firstName: '',
            surname: '',
            email: _auth.currentUser?.email ?? '',
            phoneNumber: '',
            role: UserRole.user
          );
          _firestore.collection('users').doc(uid).set(_user!.toJson());
          notifyListeners();
        }
      }, onError: (error) {
        print('Error listening to user changes: $error');
      });
    }
  }

  Future<void> fetchAllUsers() async {
    try {
      final QuerySnapshot userSnapshot = await _firestore.collection('users').get();
      _allUsers = userSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return User.fromJson(data);
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching all users: $e');
      // You might want to show an error message to the user here
    }
  }

  Future<void> updateUserRole(String userId, UserRole newRole) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'role': newRole.toString().split('.').last,
      });
      
      // Update the local list
      final userIndex = _allUsers.indexWhere((user) => user.uid == userId);
      if (userIndex != -1) {
        _allUsers[userIndex] = _allUsers[userIndex].copyWith(role: newRole);
        notifyListeners();
      }
      
      // If the updated user is the current user, update _user as well
      if (_user?.uid == userId) {
        _user = _user?.copyWith(role: newRole);
        notifyListeners();
      }
    } catch (e) {
      print('Error updating user role: $e');
      // You might want to show an error message to the user here
    }
  }
}