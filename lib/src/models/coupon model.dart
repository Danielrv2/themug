import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class CouponModel {
  final String? id;
  final String name;
  final String email;
  final String idErp;

  CouponModel({
    this.id,
    required this.email,
    required this.name ,
    required this.idErp
  });

  Map<String,dynamic> toJson(){
    return {
      'id' : id,
      'name': name,
      'email': email,
      'id_erp': idErp,
    };
  }

  factory CouponModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CouponModel(
        id: document.id,
        email: data["email"],
        name: data["id_erp"],
        idErp: data["name"]);
  }

  factory CouponModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    return CouponModel(
        id: json.id,
        name: json["name"],
        email: json["email"],
        idErp: json["id_erp"]);
  }
}

Future<String> addCoupon(CouponModel coupon) async {
  CollectionReference reference = FirebaseFirestore.instance.collection('Coupons');
  var doc = await reference.add({
    'name': coupon.name,
    'email': coupon.email,
    'id_erp': coupon.idErp,
    'createdDate': DateTime.now(),
  });
  return doc.id;
}

Future<void> deleteCoupon(String id) async {
  CollectionReference reference = FirebaseFirestore.instance.collection('Coupons');
  await reference.doc(id).delete();
}

Future<bool> couponExist(String docId) async {
  try {
    var collectionRef = FirebaseFirestore.instance.collection('Coupons');
    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  } catch (e) {
    throw e;
  }
}
