

import 'package:adast_seller/methods/encrypt.dart';
import 'package:adast_seller/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/reservation_model.dart';

class ReservationDatabaseServices {
  FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;
  Future addReservation(ReservationModel reservation) async {
    try {
      await firebaseInstance
          .collection('reservations')
          .add(reservation.toJson());
    } on FirebaseException {
      rethrow;
    }
  }

  Future updateReservation(ReservationModel reservation) async {
    try {
      await firebaseInstance
          .collection('reservations')
          .doc(reservation.id)
          .set(reservation.toJson());
    } on FirebaseException {
      rethrow;
    }
  }

  Future<List<ReservationModel>> loadReservations(String sellerId) async {
    try {
      final snapshots = await firebaseInstance
          .collection('reservations')
          .where('sellerId', isEqualTo: encryptData(sellerId))
          .get();
      return snapshots.docs
          .map(
            (e) => ReservationModel.fromSnapShot(e),
          )
          .toList();
    } on FirebaseException {
 
      rethrow;
    }
  }Future<List<TransactionModel>> loadTransactionsFromReservations(String sellerId) async {
    try {
      final snapshots = await firebaseInstance
          .collection('reservations')
          .where('sellerId', isEqualTo: encryptData(sellerId))
          .get();
      return snapshots.docs
          .map(
            (e) => TransactionModel.fromReservationModel(ReservationModel.fromSnapShot(e)),
          )
          .toList();
    } on FirebaseException {
 
      rethrow;
    }
  }
}
