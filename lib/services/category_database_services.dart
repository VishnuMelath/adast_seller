import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryDatabaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addCategory(String category) async {
    try {
      final categoryCollection = firestore.collection('category');
      var query = categoryCollection.where('name', isEqualTo: category).count();
      var snapshot = await query.get();
      if (snapshot.count == 0) {
        await categoryCollection.add({'name': category.toLowerCase()});
      }
    } on FirebaseException catch (e) {
      log(e.code.toString());
    }
  }

  Future<List<String>> getAllCategory() async {
    final categoryCollection = firestore.collection('category');
    var snapshot = await categoryCollection.get();
    return snapshot.docs
        .map(
          (e) => (e.data()['name']) as String,
        )
        .toList();
  }
}
