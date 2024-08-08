import 'dart:developer';

import 'package:adast_seller/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../methods/encrypt.dart';

class TransactoinDatabaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> withdrawFromWallet(TransactionModel transactionModel) async {
    try {
      final collection = firestore.collection('Transactions');
      await collection.add(transactionModel.toMap());
    } on FirebaseException catch (e) {
      log(e.code);
      rethrow;
    }
  }

  Future<List<TransactionModel>> getAllTransactions(String sellerId) async {
    try {
      final collection = firestore.collection('Transactions');
      final snaps =
          await collection.where('sellerId', isEqualTo: encryptData(sellerId)).get();
      final docs = snaps.docs;
      return docs
          .map(
            (e) => TransactionModel.fromJson(e),
          )
          .toList();
    } on FirebaseException catch (e) {
      log(e.code);
      rethrow;
    }
  }
}
