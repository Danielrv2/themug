import 'package:flutter/material.dart';
import 'package:second_app/src/routing/Login/login.dart';
import 'package:second_app/src/routing/Login/signup.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: const AssetImage('assets/images/logos/logo.png'),
              width: MediaQuery.of(context).size.width * 0.55,
            ),
            Column(
              children: [
                const Text(
                  'Bienvenido',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 26,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Recibe los beneficios usando nuestra aplicación',
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(25, 60, 52, 1),
                            textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15)),
                        child: const Text('Iniciar sesión'),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SingUpScreen()));
                            },
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15)),
                            child: const Text('Registrarte')))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
