import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class StampModel {
  final String? id;
  final DateTime createdDate;
  final int code;

  StampModel({
    this.id,
    required this.createdDate,
    required this.code,
  });

  toJson() {
    return {
      'createdDate': createdDate,
      'code': code,
    };
  }

  factory StampModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return StampModel(
        id: document.id, createdDate: data["createdDate"], code: data["code"]);
  }
}

Future<String> addStamp(DateTime createdDate) async {
  final int code = randomCode(0, 99999);
  CollectionReference reference =
      FirebaseFirestore.instance.collection('Stamps');
  // Call the user's CollectionReference to add a new user
  var doc = await reference.add({
    'createdDate': createdDate,
    'company': 'Client Frequency',
    'code': code,
  });
  return doc.id;
}

Future<void> deleteStamp(String id) async {
  CollectionReference reference = FirebaseFirestore.instance.collection('Stamps');
  await reference.doc(id).delete();
}

Future<bool> stampExist(String docId) async {
  try {
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance.collection('Stamps');
    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  } catch (e) {
    throw e;
  }
}

int randomCode(int min, int max) {
  return Random().nextInt(max - min + 1) + min;
}
