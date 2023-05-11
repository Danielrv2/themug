import 'package:flutter/material.dart';
import '../../services/firestore/authentication.dart';
import '../../utils/dialogs.dart';
import '../../widgets/TextInput/input.dart';

const List<String> _list = <String>['Hombre', 'Mujer'];

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  final TextEditingController _brithdayCtlr = TextEditingController();
  final TextEditingController _passwordCtlr = TextEditingController();
  final TextEditingController _cpasswordCtlr = TextEditingController();
  final TextEditingController _emailCtlr = TextEditingController();
  final TextEditingController _userNameCtlr = TextEditingController();
  final TextEditingController _phoneCtlr = TextEditingController();

  String _genderCtlr = _list.first;

  void getGender(String value) {
    _genderCtlr = value;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final value = await showDialog(context: context, builder: (context) {
            return AlertDialog(
                backgroundColor: const Color.fromRGBO(25, 60, 52, 0.95),
                title: const Text('¿Deseas regresar?',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                content: const Text('Perderas todos los datos que ingresaste',style:TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8))),
                actions:
                [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                      backgroundColor: Colors.white,
                      foregroundColor: const Color.fromRGBO(25, 60, 52, 1),
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                      onPressed: () {
                    Navigator.of(context).pop(false);
                  }, child: const Text('No')),
                  TextButton(
                    style:TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontWeight: FontWeight.w600)
                    ), onPressed: () {
                    Navigator.of(context).pop(true);
                  }, child: const Text('Si')),
                ]
            );
          });
          if (value != null) {
            return Future.value(value);
          } else {
            return Future.value(false);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black87,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "Registrarte",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          backgroundColor: const Color.fromRGBO(193, 219, 214, 1),
          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    Form(
                      key: _keyForm,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputName(userNameCtlr: _userNameCtlr),
                          const SizedBox(
                            height: 15,
                          ),
                          InputEmail(emailCtlr: _emailCtlr),
                          const SizedBox(
                            height: 15,
                          ),
                          InputPhone(phoneCtlr: _phoneCtlr),
                          const SizedBox(
                            height: 20,
                          ),
                          InputDate(brithdayCtlr: _brithdayCtlr),
                          const SizedBox(
                            height: 10,
                          ),
                          InputGender(getGender: getGender),
                          const SizedBox(
                            height: 20,
                          ),
                          InputPassword(
                            passwordController: _passwordCtlr, hintText: 'Contraseña',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InputPassword(
                            passwordController: _cpasswordCtlr, hintText: 'Confirmar contraseña',
                          ),
                          const SizedBox(height: 10,),
                          const Text(
                            'La contraseña debe contener 6 digitos numericos enteros',
                            style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black45),),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                if (_keyForm.currentState!.validate()) {
                                  try {
                                    registerNewUser(
                                        _userNameCtlr.text,
                                        _emailCtlr.text,
                                        _phoneCtlr.text,
                                        _brithdayCtlr.text,
                                        _passwordCtlr.text,
                                        _genderCtlr,
                                        'client',
                                        context);
                                  } catch (e) {
                                    showAlert(
                                        'Error',
                                        'Ha ocurrido un error inténtelo nuevamente',
                                        context);
                                  }
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(21, 173, 153, 1),
                                  textStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Montserrat'),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15)),
                              child: const Text('Registrarse'),
                            ),
                          )
                        ],
                      ),
                    )
                    /*-- Formulary --- */
                  ],
                ),
              )),
        ));
  }
}




