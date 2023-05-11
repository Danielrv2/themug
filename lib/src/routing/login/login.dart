import 'package:flutter/material.dart';
import '../../services/firestore/authentication.dart';
import '../../utils/dialogs.dart';
import '../../widgets/TextInput/input.dart';
import 'forgot_passwor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _passwordCtlr = TextEditingController();
  final TextEditingController _emailCtlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Iniciar sesión",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Accede a nuestras promociones',
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputEmail(emailCtlr: _emailCtlr),
                  const SizedBox(
                    height: 15,
                  ),
                  InputPassword(passwordController: _passwordCtlr, hintText: 'Contraseña',),
                  const SizedBox(
                    height: 40,
                  ),
                  LoginButton(
                      keyForm: _keyForm,
                      passwordController: _passwordCtlr,
                      emailController: _emailCtlr),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const BtnForgotPassword(),
          ],
        ),
      )),
    );
  }
}

class BtnForgotPassword extends StatelessWidget {
  const BtnForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const RestarPasswordScreen()));
          },
          child: const Text(
            '¿Has olvidado tu contraseña?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          )),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required GlobalKey<FormState> keyForm,
    required TextEditingController passwordController,
    required TextEditingController emailController,
  })  : _keyForm = keyForm,
        _passwordController = passwordController,
        _emailController = emailController;

  final GlobalKey<FormState> _keyForm;
  final TextEditingController _passwordController;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          if (_keyForm.currentState!.validate()) {
            try {
              loginAuthentication(
                  _passwordController.text, _emailController.text, context);
            } catch (e) {
              showAlert(
                  'Error', 'Ah ocurrido un error inténtelo de nuevo', context);
            }
          }
        },
        style: OutlinedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(25, 60, 52, 1),
            textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text('Ingresar'),
      ),
    );
  }
}
