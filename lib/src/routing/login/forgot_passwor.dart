import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/dialogs.dart';
import '../../widgets/TextInput/input.dart';

class RestarPasswordScreen extends StatefulWidget {
  const RestarPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RestarPasswordScreen();
}

class _RestarPasswordScreen extends State<RestarPasswordScreen> {
  final TextEditingController _emailCtlr = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailCtlr.dispose();
    super.dispose();
  }

  Future passwordRestart() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailCtlr.text.trim());
      showAlert('Correo enviado', 'Revise su correo electrónico y restablezca su contraseña', context);
    }on FirebaseException catch(e){
      showAlert('Error', 'Ah ocurrido un error inténtelo nuevamente', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Contraseña',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            children: [
              const Text(
                "Restablecer contraseña",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black87),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Ingrese su correo electrónico para restablecer su contraseña",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      InputEmail(emailCtlr: _emailCtlr),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              onPressed: () {
                                if (_keyForm.currentState!.validate()) {
                                  try {
                                    passwordRestart();
                                  } catch (e) {
                                    showAlert(
                                        'Error',
                                        'Ah ocurrido un error inténtelo de nuevo',
                                        context);
                                  }
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(255, 68, 56, 1),
                                  textStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Montserrat'),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  foregroundColor: Colors.white,
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 15)),
                              child: const Text('Restablecer'))),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
