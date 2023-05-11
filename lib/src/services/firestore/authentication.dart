// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../models/user_model.dart';
import '../../routing/main_ employee/main_employee.dart';
import '../../routing/main_admin/main_admin.dart';
import '../../routing/main_client/main_client.dart';
import '../../utils/dialogs.dart';
import '../../widgets/flash_message.dart';
import '../notifications.services.dart';

var auth = FirebaseAuth.instance;

Future<void> loginAuthentication(
    String password, String email, BuildContext context) async {
  try {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context){
          return const Center(child: CircularProgressIndicator(),);
        });

    await auth.signInWithEmailAndPassword(email: email, password: password);

    UserModel user = await getClientDetails(email);

    if (user.rol == 'client') {
      UserModel userModel = UserModel(id: user.id!,name: user.name, email: user.email, phone: user.phone, birthday: user.birthday, gender: user.gender, rol: user.rol, password: user.password, location: '', idRegularClient: user.idRegularClient, idSubscription: user.idSubscription);
      onSetInfoUser(userModel,context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const MainClient()
          ),(route)=> false
      );
    } else if (user.rol == 'employee') {
      UserModel userModel = UserModel(id: user.id!,name: user.name, email: user.email, phone: user.phone, birthday: user.birthday, gender: user.gender, rol: user.rol, password: user.password, location: '', idRegularClient: '', idSubscription: '');
      onSetInfoUser(userModel,context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const EmployeeMain()
          ),(route)=> false
      );
    } else if (user.rol == 'admin') {
      UserModel userModel = UserModel(id: user.id!,name: user.name, email: user.email, phone: user.phone, birthday: user.birthday, gender: user.gender, rol: user.rol, password: user.password, location: '', idRegularClient: '', idSubscription: '');
      onSetInfoUser(userModel,context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const MainAdmin()
          ),(route)=> false
      );
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Navigator.of(context).pop();
      showAlert('Correo no encontrado', 'Introduzca un correo válido', context);
    } else if (e.code == 'wrong-password') {
      Navigator.of(context).pop();
      showAlert('Contraseña incorrecta',
          'Introduzca correctamente la contraseña', context);
    } else {
      Navigator.of(context).pop();
      showAlert('Error','Ha ocurrido un error inténtelo de nuevo', context);
    }
  }catch(e){
    Navigator.of(context).pop();
    showAlert('Error','Ha ocurrido un error inténtelo de nuevo', context);
  }
}

Future<void> registerNewUser(
    String name,
    String email,
    String phone,
    String date,
    String password,
    String gender,
    String rol,
    BuildContext context) async {
  try {
    var user = await auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    if (user.user != null) {
      var usermodel = UserModel(
          name: name,
          email: email.trim(),
          phone: phone,
          birthday: date,
          gender: gender,
          rol: rol,
          password: password.trim(),
          location: '', idRegularClient: '', idSubscription: '');
      addUser(usermodel);
      final snackBar = SnackBar(
        duration: const Duration(milliseconds: 1500),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(92, 184, 92,1),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.check_circle,weight: 20,color: Colors.white),
              SizedBox(width: 20,),
              Text('Completado',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.w500),)
            ],
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if(usermodel.rol == 'client'){
        showNotification(id: 10612 , title: 'Gracias por registrarte', body: 'Has recibido 3 sellos de cliente frecuente');
      }

      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pop(context);
      });

    } else {
      showAlert('Error', 'Ha ocurrido un error inténtelo de nuevo', context);
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showAlert('La contraseña es débil',
          'La contraseña debe tener un mínimo de 6 dígitos', context);
    } else if (e.code == 'email-already-in-use') {
      showAlert('El correo ya está en uso', 'Ingrese otro correo electrónico',
          context);
    } else {
      showAlert('Error', 'Ha ocurrido un error inténtelo de nuevo', context);
    }
  } catch (e) {
    showAlert('Error', 'Ha ocurrido un error inténtelo de nuevo', context);
  }
}

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          var snackBar = const FlashMessage(message: 'Completado', colorMessage: Color.fromRGBO(0, 200, 81,1));
          ScaffoldMessenger.of(context).showSnackBar(snackBar as SnackBar);
        },
        child: const Text('Show SnackBar'),
      ),
    );
  }
}