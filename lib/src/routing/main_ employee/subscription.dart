import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:second_app/src/routing/main_%20employee/qr/scan_coupon.dart';
import 'package:second_app/src/routing/main_%20employee/qr/scan_subscription.dart';

class EmployeeSubscription extends StatelessWidget {
  const EmployeeSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            children: [
              const Text(
                'Escanear QR de subscripción',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmployeScanSusbcription()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 68, 56,1),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25)
                ),
                child: Column(
                  children: [
                    QrImage(
                      foregroundColor: const Color.fromRGBO(251, 240, 222,1),
                      size: 150,
                      data: 'Subscripción',
                      eyeStyle: const QrEyeStyle(color: Colors.black54,eyeShape: QrEyeShape.circle),
                    ),
                    const Text(
                      'Escanear QR',
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