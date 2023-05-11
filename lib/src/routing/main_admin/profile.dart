import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';
import '../welcome.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadUserCubit, ReadUser>(
        builder: (context, state) {
          return SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                children: [
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Perfil',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                        const Padding(padding: EdgeInsets.all(10)),
                        Container(
                          padding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.person_outline),
                              const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                              Text(state.userModel.name,
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
                            border: Border.all(color: Colors.black, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.email_outlined),
                              const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                              Text(state.userModel.email,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black))
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(255, 68, 56, 1),
                                  textStyle: const TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w700,fontFamily: 'Montserrat'),
                                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 15)),
                              onPressed: () {
                                FirebaseAuth.instance.signOut().then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const WelcomeScreen()));
                                });
                              },
                              child: const Text('Cerrar sesion')),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}
