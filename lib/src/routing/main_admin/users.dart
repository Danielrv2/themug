import 'package:flutter/material.dart';
import '../main_client/main_routing/home/home_subscription.dart';
import '../main_client/terms_conditions.dart';
import 'adminsUser/admins.dart';
import 'adminsUser/employes.dart';

class UsersHome extends StatelessWidget {
  const UsersHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
          const Text(
            'Administrar usuarios',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: 1),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminEmployes()));
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(25, 60, 52, 1),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 25)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.badge_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Empleados')
                    ],
                  ))),
              const SizedBox(
                height: 20,
              ),
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminAdmins()));
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 68, 56, 1),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 25)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.assignment_ind_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Administradores')
                    ],
                  ))),
        ]));
  }
}
