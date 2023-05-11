import 'package:cloud_firestore/cloud_firestore.dart';

final _db = FirebaseFirestore.instance;

class SubscriptionModel {
  final String? id;
  final String email;
  final int nCoffee;
  final Map<String,dynamic>? lastBuy;
  final List? buys;
  final int nBuys;
  final String? coffeeStatus;

  SubscriptionModel({this.id, required this.email,required this.nCoffee,this.lastBuy,this.buys,required this.nBuys, required this.coffeeStatus});

  factory SubscriptionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return SubscriptionModel(
        id: document.id,
        email: data["email"],
        nCoffee: data["nCoffee"],
        lastBuy: data["lastBuy"],
        buys: data["buys"],
        nBuys: data["nBuys"],
        coffeeStatus: data["coffeeStatus"]
    );
  }
}

Future<SubscriptionModel> getSubscriptionId(String regularClientId) async {
  var collectionRef = _db.collection('Subscription');
  var snapshot = await collectionRef.doc(regularClientId).get();
  final data = snapshot.data()!;
  return SubscriptionModel(id:snapshot.id, email: data['email'], nCoffee: data['nCoffee'], nBuys: data['nBuys'], coffeeStatus: data["coffeeStatus"],lastBuy:data["lastBuy"],buys: data["buys"]);
}

Future<void> updateCoffeeStatus(SubscriptionModel subscriptionModel,String idCoffee)async {

    await _db.collection('Subscription').doc(subscriptionModel.id).update(
        {
          "coffeeStatus": idCoffee,
        }
    );
}

Future<void> updateSubscription(SubscriptionModel subscriptionModel)async {

  final int nCoffee = subscriptionModel.nCoffee - 1;
  await _db.collection('Subscription').doc(subscriptionModel.id).update(
      {
        "nCoffee": nCoffee,
        "coffeeStatus": null,
      }
  );
}

Future<void> paySubscription(SubscriptionModel subscriptionModel)async {

  final DateTime buyDate = DateTime.now();
  final DateTime expDate = buyDate.add(const Duration(days: 30));
  final int nbuys =  subscriptionModel.nBuys + 1;

  Map<String, dynamic> lastbuys =
    {
      "buyDate": buyDate,
      "expDate": expDate,
    };

  List? buys = subscriptionModel.buys!;
  buys.add(lastbuys);

  await _db.collection('Subscription').doc(subscriptionModel.id).set(
      {
        "email" : subscriptionModel.email,
        "nCoffee": 10,
        "buys": buys,
        "nBuys": nbuys ,
        "lastBuy": lastbuys,
        "coffeeStatus": subscriptionModel.coffeeStatus,
      }
  );
}
