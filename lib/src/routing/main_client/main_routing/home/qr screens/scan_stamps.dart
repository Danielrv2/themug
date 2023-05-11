import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../../../main.dart';
import '../../../../../models/regular_client_model.dart';
import '../../../../../models/stamps_model.dart';
import '../../../../../utils/dialogs.dart';
import '../../../main_client.dart';

class ClientScanStamps extends StatefulWidget {
  final RegularClientModel regularClient;

  const ClientScanStamps({super.key, required this.regularClient});

  @override
  State<ClientScanStamps> createState() => _QRRegularClientScreen();
}

class _QRRegularClientScreen extends State<ClientScanStamps> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadUserCubit, ReadUser>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('QR Escáner',
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
                      Text('Escaneo de QR',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Escanea el QR para canjear un sello de cliente frecuente',
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
                            129, 199, 189, 1),
                        data: code == null ? 'Lest Go' : code!,
                        size: code == null ? 0 : MediaQuery
                            .of(context)
                            .size
                            .width * 0.5,
                      ),
                      ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                  maximumSize: const Size.fromWidth(200),
                                  backgroundColor: code == null ? const Color.fromRGBO(255, 68, 56, 1) :const Color.fromRGBO(129, 199, 189, 1),
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
                                children:  [
                                  const Icon(Icons.qr_code_scanner_outlined),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(code == null ? 'Escanear' : 'Escaneado',
                                      style: const TextStyle(
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
                              showAlert('Error', 'Escanea un sello', context);
                            }
                          : () async {
                              try {
                                bool existStamp = await stampExist(code!);
                                if (existStamp == true) {
                                  updateRegularClient(widget.regularClient);
                                  deleteStamp(code!);
                                  final snackBar = SnackBar(
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    content: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(92, 184, 92, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.check_circle,
                                              weight: 20, color: Colors.white),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Sello canjeado',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const MainClient()),
                                      (route) => false);
                                } else {
                                  showAlert(
                                      'Error', 'El sello es inválido', context);
                                }
                              } catch (e) {
                                showAlert(
                                    'Error',
                                    'Ha ocurrido un error inténtalo de nuevo',
                                    context);
                              }
                            },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: code == null ? const Color.fromRGBO(100, 100, 100, 1): const Color.fromRGBO(25, 60, 52, 1),
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
                          Text('Canjear sello',
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
    });
  }
}
