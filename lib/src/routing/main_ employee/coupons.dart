import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:second_app/src/routing/main_%20employee/qr/scan_coupon.dart';

class EmployeeCoupons extends StatelessWidget {
  const EmployeeCoupons({super.key});

  final String body = '¿Seguro que deseas crear un cupon?';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            children: [
          const Text(
            'Escanear cupón',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EmployeScanCoupon()));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(25, 60, 52, 1),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30)),
            child: Column(
              children: [
                QrImage(
                  foregroundColor: Color.fromRGBO(251, 240, 222, 1),
                  size: 150,
                  data: 'Coupons',
                  eyeStyle: const QrEyeStyle(
                      color: Colors.black54, eyeShape: QrEyeShape.circle),
                ),
                const Text(
                  'Escanear',
                  style: TextStyle(
                      color: Color.fromRGBO(251, 240, 222, 1),
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          )
        ]));
  }
}
