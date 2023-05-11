import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import 'add_admin.dart';
import 'edit_admins.dart';

class AdminAdmins extends StatelessWidget {
  const AdminAdmins({super.key});

  @override
  Widget build(BuildContext context) {
    List<UserModel> allusers = [];
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Empleados",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 20),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Users').where('rol', isEqualTo: 'admin').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                      child: Text('Ah ocurrido un error'));
                }
                if (snapshot.hasData) {
                  allusers = snapshot.data!.docs
                      .map((doc) =>
                      UserModel.fromJson(
                          doc as DocumentSnapshot<Map<String, dynamic>>))
                      .toList();

                  return ListView.builder(
                      itemCount: allusers.length,
                      itemBuilder: (context, index) {
                        return UserCard(userModel: allusers[index]);
                      }
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreatedAdmin()));
        },
        backgroundColor: Color.fromRGBO(143, 208, 179,1),
        child: const Icon(Icons.add_circle_outline),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserModel userModel;
  const UserCard({super.key, required this.userModel,});
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical:10),
        child: ListTile(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditAdmins(userModel:userModel)));

          },
          contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          leading:CircleAvatar(
            child:  Text(userModel.name[0]),
          ),
          title: Text(userModel.name, style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
          subtitle: Text(userModel.email),
          trailing: const Icon(Icons.arrow_forward),
        )
    );
  }
}