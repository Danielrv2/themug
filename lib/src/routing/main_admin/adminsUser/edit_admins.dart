
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../utils/dialogs.dart';

class EditAdmins extends StatelessWidget{
  final UserModel userModel;
  const EditAdmins({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: const Color.fromRGBO(25, 60, 52,1),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Informacion",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              children: [
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person_outline),
                            const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                            Text(userModel.name,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black))
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.email_outlined),
                            const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                            Text(userModel.email,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.phone_outlined),
                            const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                            Text(userModel.phone,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),)
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.date_range_outlined),
                            const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                            Text(userModel.birthday,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black))
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person_pin_outlined),
                            const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                            Text(userModel.gender,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(129, 199, 189, 1),
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Montserrat'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 15)),
                            onPressed: () {
                              try{
                                deleteUser(userModel.id!,userModel.email,userModel.password);
                                Navigator.pop(context);
                              }catch(e){
                                showAlert('Error', 'Ah ocurrido un error intetnelod e nuevo',context);
                              }
                            },
                            child: const Text('Eliminar')),
                      ),
                    ],
                  ),
                )
              ],
            ))
    );
  }

}
