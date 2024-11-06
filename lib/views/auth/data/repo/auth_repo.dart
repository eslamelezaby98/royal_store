import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:royal_store/views/auth/data/model/user_model.dart';
import 'package:royal_store/views/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel> signIn(String email, String password) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User? user = credential.user;
    if (user == null) throw Exception('Failed to sign in');

    final userData = await _firestore.collection('users').doc(user.uid).get();

    return UserModel(
      uid: user.uid,
      email: userData['email'],
      username: userData['username'],
    );
  }

  @override
  Future<UserModel> signUp(
    String email,
    String password,
    String username,
  ) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User? user = credential.user;
    if (user == null) throw Exception('Failed to create user');

    final userModel = UserModel(
      uid: user.uid,
      email: email,
      username: username,
    );

    await saveUserData(userModel);
    return userModel;
  }

  @override
  Future<void> saveUserData(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  @override
  Future logout() async {
    await _auth.signOut();
  }
}
