import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/seller_model.dart';
import 'user_database_services.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithMailandPass(String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await DatabaseServices().getSellerData(user.user!.email!);
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

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? gSeller = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gSeller!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      await _auth.signInWithCredential(credential).then((user) async {
        var map = user.additionalUserInfo;
        if (user.additionalUserInfo!.isNewUser) {
          SellerModel sellerModel = SellerModel(
              email: map!.profile?['email'],
              name: map.profile?['given_name'],
              image: map.profile?['picture']);
          await DatabaseServices().addSeller(sellerModel);
        }
        log(user.credential.toString());
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
