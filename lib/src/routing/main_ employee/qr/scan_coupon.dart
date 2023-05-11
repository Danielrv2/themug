// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:second_app/src/models/subscription_model.dart';
import '../../../models/coupon model.dart';
import '../../../models/subscriptionCoffee.dart';
import '../../../utils/dialogs.dart';

class EmployeScanCoupon extends StatefulWidget {
  const EmployeScanCoupon({
    super.key,
  });

  @override
  State<EmployeScanCoupon> createState() => _EmployeScanCoupon();
}

class _EmployeScanCoupon extends State<EmployeScanCoupon> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('escáner de cupón',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Builder(builder: (context) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: const [
                    Text('Escanea el QR',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Escanea el QR para redimir un cupón',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    QrImage(
                      foregroundColor: code == null ? const Color.fromRGBO(
                          235, 235, 235, 0.8) : const Color.fromRGBO(
                          25, 60, 52, 1),
                      data: code == null ? 'Lest Go' : code!,
                      size: MediaQuery
                          .of(context)
                          .size
                          .width * 0.5,
                    ),
                    //Text(code == null? 'Result': 'Result: ${code!}',style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black87)),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            maximumSize: const Size.fromWidth(200),
                            backgroundColor:
                            const Color.fromRGBO(129, 199, 189, 1),
                            textStyle:
                            const TextStyle(fontFamily: 'Montserrat'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15)),
                        onPressed: () {
                          _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                              context: context,
                              onCode: (code) {
                                setState(() {
                                  this.code = code;
                                });
                              });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.camera_alt_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Escanear',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ],
                        )),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: code == null
                        ? () {
                      showAlert('Error', 'Escanea un  cupón', context);
                    }
                        : () async {
                      try {
                        bool existCoupon = await couponExist(code!);
                        if (existCoupon == true) {
                          var snapshot = await FirebaseFirestore
                              .instance
                              .collection('Coupons')
                              .doc(code!)
                              .get();
                          var data = snapshot.data();
                          CollectionReference reference =
                          FirebaseFirestore.instance
                              .collection('CouponsCanjed');
                          var idErp = await data!['id_erp'];
                          await reference.add({
                            'name': data['name'],
                            'email': data['email'],
                            'id_erp': data['id_erp'],
                            'createdDate': data['createdDate'],
                            'canjedDate': DateTime.now()
                          });
                          confirmationScan(
                              'Completado',
                              'id: $idErp',
                              context);
                          deleteCoupon(code!);
                        } else {
                          showAlert('Error', 'El cupón es inválido',
                              context);
                        }
                      } catch (e) {
                        showAlert(
                            'Error',
                            'Ha ocurrido un error inténtalo de nuevo',
                            context);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(25, 60, 52, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.change_circle,
                          size: 24,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text('Canjear cupon',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'Montserrat')),
                      ],
                    ),
                  ),
                ),
              ],
            ));
      }),
    );
  }
}
