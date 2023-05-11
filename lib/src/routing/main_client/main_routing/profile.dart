import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:second_app/src/routing/welcome.dart';
import '../../../../main.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  final TextEditingController _phoneController = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
      mask: '####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadUserCubit, ReadUser>(builder: (context, state) {
      return SafeArea(
          child:Padding(
            padding: const EdgeInsets.all(20),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Perfil',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const Padding(padding: EdgeInsets.all(10)),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person_outline, color: Colors.black54),
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
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.email_outlined, color: Colors.black54),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text(state.userModel.email,
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
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.date_range_outlined,
                            color: Colors.black54,
                          ),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text(state.userModel.birthday,
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
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person_pin_outlined,
                            color: Colors.black54,
                          ),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text(
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              state.userModel.gender)
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.phone_outlined,
                            color: Colors.black54,
                          ),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text(state.userModel.phone,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black))
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(255, 68, 56, 1),
                          textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15)),
                      onPressed: () {
                        showDialog(
                            context:context,
                            builder: (context) => AlertDialog(
                              title: const Text('¿Deseas cerrar sesión?'),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: const Text('No')),
                                TextButton(onPressed: (){

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const WelcomeScreen()));
                                }, child: const Text('Si')),
                              ],
                            )
                        );
                      },
                      child: const Text('Cerrar sesión')),
                ),
              ],
            ),
          ));
    });
  }
}

class inputPhone extends StatefulWidget {
  const inputPhone({
    super.key,
    required TextEditingController passwordController,
    required this.passFormatter,
    required this.phone,
  }) : _passwordController = passwordController;

  final String phone;
  final TextEditingController _passwordController;
  final MaskTextInputFormatter passFormatter;

  @override
  State<inputPhone> createState() => _inputPhone();
}

class _inputPhone extends State<inputPhone> {
  bool readOnly = false;

  void readOnlYState() {
    setState(() {
      readOnly = !readOnly;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.phone,
      enabled: true,
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(
          fontWeight: FontWeight.w500, letterSpacing: 1, fontSize: 18),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w400, letterSpacing: 0, fontSize: 16),
          prefixIcon: const Icon(Icons.phone_outlined),
          hintText: 'Numero de telefono',
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {
              readOnlYState();
            },
            icon: !readOnly
                ? const Icon(Icons.edit_document)
                : const Icon(Icons.save_alt_outlined),
          )),
      inputFormatters: [widget.passFormatter],
      validator: (value) {
        if (value!.isEmpty) {
          return 'El campo esta vacio';
        } else {
          return null;
        }
      },
    );
  }
}
