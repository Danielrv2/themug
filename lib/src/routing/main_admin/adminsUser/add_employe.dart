import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../services/firestore/authentication.dart';
import '../../../utils/dialogs.dart';

const List<String> _list = <String>['Hombre', 'Mujer'];

class CreatedEmploye extends StatefulWidget {
  const CreatedEmploye({super.key});

  @override
  State<StatefulWidget> createState() => _CreatedEmploye();
}

class _CreatedEmploye extends State<CreatedEmploye> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _brithdayController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _genderController = _list.first;

  void getGender(String value) {
    _genderController = value;
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var passFormatter = MaskTextInputFormatter(
      mask: '######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color.fromRGBO(25, 60, 52,1),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Crear empleado",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: const Color.fromRGBO(193, 219, 214, 1),
      body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                /*-- Formulary --- */
                Form(
                  key: _keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                        controller: _userNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline),
                            hintText: 'Nombre'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'El campo esta vacio';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 17),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'El campo esta vacio';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone_outlined),
                          hintText: 'Telefono',
                        ),
                        inputFormatters: [maskFormatter],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'El campo esta vacio';
                          } else if (value.length != 9) {
                            return 'el formato es xxxx-xxxx';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      dateTextField(_brithdayController, context),
                      const Padding(padding: EdgeInsets.all(5)),
                      DropdownButtonGender(getGender: getGender),
                      const Padding(padding: EdgeInsets.all(10)),
                      InputPassword(
                        passwordController: _passwordController,
                        passFormatter: passFormatter,
                        hintText: 'Contraseña',
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              try {
                                registerNewUser(
                                    _userNameController.text,
                                    _emailController.text,
                                    _phoneController.text,
                                    _brithdayController.text,
                                    _passwordController.text,
                                    _genderController,
                                    'employee',
                                    context);
                              } catch (e) {
                                showAlert(
                                    'Error',
                                    'Ah ocurrido un error intentelo nuevamente',
                                    context);
                              }
                            }
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                              const Color.fromRGBO(25, 60, 52,1),
                              textStyle: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Montserrat'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15)),
                          child: const Text('Crear'),
                        ),
                      )
                    ],
                  ),
                )
                /*-- Formulary --- */
              ],
            ),
          )),
    );
  }
}

TextFormField dateTextField(
    TextEditingController controller, BuildContext context) {
  return TextFormField(
    style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return 'El campo esta vacio';
      } else {
        return null;
      }
    },
    decoration: const InputDecoration(
      prefixIcon: Icon(
        Icons.date_range_outlined,
      ),
      hintText: 'Fecha de nacimiento',
    ),
    readOnly: true,
    onTap: () async {
      DatePicker.showDatePicker(context,
          showTitleActions: true,
          minTime: DateTime(1920, 1, 1),
          maxTime: DateTime.now(),
          onChanged: (date) {
            controller.text = '${date.day}/${date.month}/${date.year}';
          }, onConfirm: (date) {
          }, currentTime: DateTime.now(), locale: LocaleType.es);
    },
  );
}

class InputPassword extends StatefulWidget {
  const InputPassword({
    super.key,
    required TextEditingController passwordController,
    required this.passFormatter,
    required this.hintText,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;
  final MaskTextInputFormatter passFormatter;
  final String hintText;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool obscureText = false;

  void obscureTextState() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._passwordController,
      obscureText: !obscureText,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w400, letterSpacing: 0, fontSize: 18),
          prefixIcon: const Icon(Icons.lock_outline),
          hintText: widget.hintText,
          suffixIcon: IconButton(
            onPressed: () {
              obscureTextState();
            },
            icon: obscureText
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
          )),
      inputFormatters: [widget.passFormatter],
      validator: (value) {
        if (value!.isEmpty) {
          return 'El campo esta vacio';
        } else if (value.length != 6) {
          return 'requiere como minimo de 6 digitos';
        } else {
          return null;
        }
      },
    );
  }
}

class DropdownButtonGender extends StatefulWidget {
  const DropdownButtonGender({super.key, required this.getGender});

  final Function(String value) getGender;

  @override
  State<DropdownButtonGender> createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropdownButtonGender> {
  String dropdownValue = _list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: const Color.fromRGBO(129, 199, 189,1),
      style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 18,color:Colors.black87,fontFamily: 'Montserrat'),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.attribution_outlined),
        label: Text('Genero'),
      ),
      value: dropdownValue,
      isExpanded: true,
      onChanged: (String? value) {
        widget.getGender(value!);
        setState(() {
          dropdownValue = value;
        });
      },
      items: _list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
