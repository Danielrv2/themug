import 'package:cloud_firestore/cloud_firestore.dart';

import 'coupon model.dart';

final _db = FirebaseFirestore.instance;

class RegularClientModel {
  final String? id;
  final String email;
  final int counter;
  final int redemptions;

  RegularClientModel({
    this.id,
    required this.email,
    required this.counter,
    required this.redemptions,
  });

  toJson() {
    return {
      'counter': counter,
      'redemptions': redemptions,
      'email': email
    };
  }

  factory RegularClientModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return RegularClientModel(
        id: document.id,
        counter: data["counter"],
        email: data["email"],
        redemptions: data["redemptions"]);
  }

  factory RegularClientModel.empty() {
    return RegularClientModel(
        id: '',
        counter: 0,
        email: '',
        redemptions: 0);
  }

}

Future<int> getRegularClientCounterId(String regularclientId) async {
  var collectionRef = _db.collection('ClientFrecuency');
  var snapshot = await collectionRef.doc(regularclientId).get();
  final data = snapshot.data()!;
  return data['counter'];
}


Future<RegularClientModel> getRegularClientId(String regularclientId) async {
  var collectionRef = _db.collection('ClientFrecuency');
  var snapshot = await collectionRef.doc(regularclientId).get();
  final data = snapshot.data()!;
  return RegularClientModel(id:snapshot.id,email: data['email'], counter: data['counter'], redemptions: data['redemptions']);
}

Future<RegularClientModel>  getRegularClientDetails(String email) async {
  final snapshot =
    await _db.collection('ClientFrecuency').where('email', isEqualTo: email).get();
  final clientData = snapshot.docs.map((e) => RegularClientModel.fromSnapshot(e)).single;
  return clientData;
}

Future<void> updateRegularClient(RegularClientModel regularClientModel)async {

  int newCounter = regularClientModel.counter + 1;
  int newRedentions = regularClientModel.redemptions + 1;
  final DateTime createdDate = DateTime.now();
  const String name = 'Café gratis';
  final String idErp = '${regularClientModel.email[0]}${createdDate.month}${createdDate.day}${createdDate.hour}${createdDate.second}';

  if(newCounter == 12){
    await _db.collection('ClientFrecuency').doc(regularClientModel.id).update(
        {
          "counter": 0,
          "redemptions": newRedentions,
        }
    );
    CouponModel coupon = CouponModel(email: regularClientModel.email,name: name, idErp: idErp);
    addCoupon(coupon);
  }else{
    await _db.collection('ClientFrecuency').doc(regularClientModel.id).update(
        {
          "counter": newCounter,
          "redemptions": newRedentions,
        }
    );
  }
}

