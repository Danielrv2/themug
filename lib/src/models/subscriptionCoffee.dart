import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_app/src/models/subscription_model.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;

class SubscriptionCoffeeModel {

  final String? id;
  final String idSubscription;
  final DateTime createdDate;
  final String id_erp;

  SubscriptionCoffeeModel(
      {required this.createdDate, required this.idSubscription, this.id, required this.id_erp,});
}


  Future<SubscriptionCoffeeModel> getCoffeeId(
      String subscriptionCoffeeId) async {
    var collectionRef = _db.collection('SubscriptionCoffees');
    var snapshot = await collectionRef.doc(subscriptionCoffeeId).get();
    final data = snapshot.data()!;
    return SubscriptionCoffeeModel(id: snapshot.id,
        idSubscription: data['idSubscription'],
        createdDate: data['createdDate'],
        id_erp: data['id_erp']);
  }

  Future<String> addSubscriptionCoffee(
      SubscriptionModel subscriptionModel) async {
    DateTime now = DateTime.now();
    String id_erp = '${now.month}${now.day}${now.second}${now.minute}';
    CollectionReference reference = FirebaseFirestore.instance.collection(
        'SubscriptionCoffees');
    var doc = await reference.add({
      "createdDate": DateTime.now(),
      "idSubscription": subscriptionModel.id,
      "id_erp": id_erp,
    });
    return doc.id;
  }

  Future<void> deleteSubscriptionCoffee(String id) async {
    CollectionReference reference = FirebaseFirestore.instance.collection(
        'SubscriptionCoffees');
    await reference.doc(id).delete();
  }

