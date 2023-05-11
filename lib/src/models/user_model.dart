import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _db = FirebaseFirestore.instance;

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String birthday;
  final String gender;
  final String rol;
  final String password;
  final String location;
  final String idRegularClient;
  final String idSubscription;

  UserModel(
      {this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.birthday,
      required this.gender,
      required this.rol,
      required this.password,
      required this.location,
      required this.idRegularClient,
      required this.idSubscription});

  toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'birthday': birthday,
      'gender': gender,
      'rol': rol,
      'password': password,
      'location': location,
      'idRegularClient': idRegularClient,
      'idSubscription': idSubscription
    };
  }

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    return UserModel(
      id: document.id,
      name: document["name"],
      email: document["email"],
      phone: document["phone"],
      birthday: document["birthday"],
      gender: document["gender"],
      rol: document["rol"],
      password: document["password"],
      location: '',
      idRegularClient: document["idRegularClient"],
      idSubscription: document["idSubscription"],
    );
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      name: data["name"],
      email: data["email"],
      phone: data["phone"],
      birthday: data["birthday"],
      gender: data["gender"],
      rol: data["rol"],
      password: data["password"],
      location: '',
      idRegularClient: data["idRegularClient"],
      idSubscription: data["idSubscription"],
    );
  }

  factory UserModel.empty() {
    return UserModel(
      id: '',
      name: '',
      email: '',
      phone: '',
      birthday: '',
      gender: '',
      rol: '',
      password: '',
      location: '',
      idRegularClient: '',
      idSubscription: '',
    );
  }
}

Future<void> addUser(UserModel clientModel) async {
  if (clientModel.rol == 'client') {
    String idRegularClient = await _db.collection('ClientFrecuency').add({
      "email": clientModel.email,
      "counter": 3,
      "redemptions": 0,
    }).then((value) => value.id);

    String idSuscription = await _db.collection('Subscription').add({
      "email": clientModel.email,
      "nCoffee": 0,
      "buys": null,
      "nBuys": 0,
      "lastBuy": null,
      "coffeeStatus": null,
    }).then((value) => value.id);

    await _db.collection('Users').add({
      "name": clientModel.name,
      "email": clientModel.email,
      "phone": clientModel.phone,
      "birthday": clientModel.birthday,
      "password": clientModel.password,
      "gender": clientModel.gender,
      "rol": clientModel.rol,
      "created_date": DateTime.now(),
      "idRegularClient" : idRegularClient,
      "idSubscription" : idSuscription,
    });

  }else{
    await _db.collection('Users').add({
      "name": clientModel.name,
      "email": clientModel.email,
      "phone": clientModel.phone,
      "birthday": clientModel.birthday,
      "password": clientModel.password,
      "gender": clientModel.gender,
      "rol": clientModel.rol,
      "created_date": DateTime.now(),
      "idRegularClient" : '',
      "idSubscription" : '',
    });
  }
}

Future<UserModel> getClientDetails(String email) async {
  final snapshot =
      await _db.collection('Users').where('email', isEqualTo: email).get();
  final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  return userData;
}

Future<void> deleteUser(String id,String email,String password) async {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('Users');
  await reference.doc(id).delete();
}
