import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EmployeCreateStamp extends StatelessWidget {
  final String data;

  const EmployeCreateStamp({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromRGBO(129, 199, 189, 1),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                "Generador de QR",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.qr_code_scanner,size: 30),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Escanea el QR para generar el sello',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(120,120,120,1)
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  QrImage(
                    data: data,
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
