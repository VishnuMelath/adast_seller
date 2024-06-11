import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/seller_model.dart';
import 'user_database_services.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<SellerModel> signInWithMailandPass(
      String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      log(user.additionalUserInfo.toString());
      return await DatabaseServices().getSellerData(user.user!.email!);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<SellerModel> signUp(SellerModel user, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: user.email, password: password)
          .then((value) {
        log(value.user!.photoURL ?? '');
      });
      await DatabaseServices().addSeller(user);
      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<SellerModel?> checkLogin() async {
  try {
    User? user= _auth.currentUser;
    if(user==null)
    {
      return null;
    }
    else
    {
      return await DatabaseServices().getSellerData(user.email!);
    }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<(String?, bool)> signUpWithGoogle() async {
    late AdditionalUserInfo? map;
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? gSeller = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gSeller!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      await _auth.signInWithCredential(credential).then((user) async {
        log(user.additionalUserInfo.toString());
        map = user.additionalUserInfo;
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      rethrow;
    }
    if (map!.isNewUser) {
      return (map!.profile?['email'].toString(), true);
    } else {
      return (map!.profile?['email'].toString(), false);
    }
  }
}
