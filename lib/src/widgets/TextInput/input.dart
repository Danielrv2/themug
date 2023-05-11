import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({
    super.key,
    required TextEditingController passwordController, required this.hintText,
  }) : _passwordController = passwordController;

  final String hintText;
  final TextEditingController _passwordController;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {

  MaskTextInputFormatter passwordFormater = MaskTextInputFormatter(
      mask: '######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void obscureTextState() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._passwordController,
      obscureText: !obscureText,
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(
          fontWeight: FontWeight.w500,fontSize: 18),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
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
      inputFormatters: [passwordFormater],
      validator: (value) {
        if (value!.isEmpty) {
          return 'El campo está vacío';
        } else if (value.length != 6) {
          return 'La contraseña debe contener 6 dígitos';
        } else {
          return null;
        }
      },
    );
  }
}

class InputEmail extends StatelessWidget {
  const InputEmail({
    super.key,
    required TextEditingController emailCtlr,
  }) : _emailCtlr = emailCtlr;

  final TextEditingController _emailCtlr;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailCtlr,
      style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18),
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        hintText: 'Correo electrónico',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'El campo está vacío';
        } else {
          return null;
        }
      },
    );
  }
}

class InputName extends StatelessWidget {
  const InputName({
    super.key,
    required TextEditingController userNameCtlr,
  }) : _userNameCtlr = userNameCtlr;

  final TextEditingController _userNameCtlr;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18),
      controller: _userNameCtlr,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person_outline),
          hintText: 'Nombre'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'El campo está vacío';
        } else {
          return null;
        }
      },
    );
  }
}

class InputPhone extends StatelessWidget {
  InputPhone({
    super.key,
    required TextEditingController phoneCtlr,
  }) : _phoneCtlr = phoneCtlr;

  final TextEditingController _phoneCtlr;

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
      mask: '####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18),
      controller: _phoneCtlr,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.phone_outlined),
        hintText: 'Teléfono',
      ),
      inputFormatters: [maskFormatter],
      validator: (value) {
        if (value!.isEmpty) {
          return 'El campo está vacío';
        } else if (value.length != 9) {
          return 'El formato es xxxx-xxxx';
        } else {
          return null;
        }
      },
    );
  }
}

class InputDate extends StatelessWidget {
  const InputDate({
    super.key,
    required TextEditingController brithdayCtlr,
  }) : _brithdayCtlr = brithdayCtlr;

  final TextEditingController _brithdayCtlr;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
          fontWeight: FontWeight.w500, fontSize: 18),
      controller: _brithdayCtlr,
      validator: (value) {
        if (value!.isEmpty) {
          return 'El campo está vacío';
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
              _brithdayCtlr.text =
              '${date.day}/${date.month}/${date.year}';
            },
            onConfirm: (date) {},
            currentTime: DateTime.now(),
            locale: LocaleType.es);
      },
    );
  }
}

class InputGender extends StatefulWidget {
  const InputGender({super.key, required this.getGender});

  final Function(String value) getGender;

  @override
  State<InputGender> createState() => _InputGender();
}

const List<String> _list = <String>['Hombre', 'Mujer'];

class _InputGender extends State<InputGender> {

  String dropdownValue = _list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: Colors.white,
      style: const TextStyle(fontWeight: FontWeight.w500,
          fontSize: 18,
          color: Colors.black54,
          fontFamily: 'Montserrat'),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.attribution_outlined),
        label: Text('Género'),
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