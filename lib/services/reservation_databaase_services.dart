

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

  Future<List<ReservationModel>> loadReservations(String userId) async {
    try {
      final snapshots = await firebaseInstance
          .collection('reservations')
          .where('sellerId', isEqualTo: userId)
          .get();
      return snapshots.docs
          .map(
            (e) => ReservationModel.fromSnapShot(e),
          )
          .toList();
    } on FirebaseException {
 
      rethrow;
    }
  }
}
