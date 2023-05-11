import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../utils/dialogs.dart';

class EmployeeRegularClient extends StatelessWidget {
  const EmployeeRegularClient({super.key});
  final String body = '¿Seguro que deseas crear un cupón?';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            children: [
          const Text(
            'Crear QR para cliente frecuente',
             style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          ElevatedButton(
            onPressed: () {
              showConfirmationDialog(context,body);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(129, 199, 189,1),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25)
            ),
            child: Column(
              children: [
                QrImage(
                    foregroundColor: const Color.fromRGBO(251, 240, 222,1),
                    size: 150,
                    data: 'Cliente frecuente',
                    eyeStyle: const QrEyeStyle(color: Colors.black54,eyeShape: QrEyeShape.circle),
                ),
                const Text(
                  'Crear QR',
                  style: TextStyle(
                    color: Color.fromRGBO(251, 240, 222,1),
                    fontSize: 22,
                    fontWeight: FontWeight.w700
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
