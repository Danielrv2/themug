import 'package:flutter/material.dart';
import 'package:second_app/src/routing/main_client/main_routing/home/qr%20screens/scan_stamps.dart';
import '../../../../models/regular_client_model.dart';

String benefis = 'Recibe beneficios por tus compras en nuestra sucursal. Complete un total de 12 compras y recibe un cupón';

class ClientHomeRegularClient extends StatelessWidget {
  final RegularClientModel regularClient;
  const ClientHomeRegularClient({super.key, required this.regularClient});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Cliente frecuente",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: mediaQuery.size.height * 0.45,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                    image: AssetImage('assets/images/covers/RegularClient.jpg')),),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height * 0.60,
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text("Beneficios", style: TextStyle(color: Color.fromRGBO(40, 40, 40, 1), fontSize: 22, fontWeight: FontWeight.w600),),
                        const SizedBox(height: 5,),
                        Text(benefis, style: const TextStyle(color: Color.fromRGBO(130,130, 130, 1), height: 1.4, fontSize: 18, fontWeight: FontWeight.w400),),
                        const SizedBox(height: 20,),
                        const Text("Sellos", style: TextStyle(color: Color.fromRGBO(40, 40, 40, 1), fontSize: 22, fontWeight: FontWeight.w600),),
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 10,
                              runSpacing: 10,
                              children: stampList(regularClient.counter)),
                        ),
                        const SizedBox(height: 30,),
                        SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>  ClientScanStamps(regularClient: regularClient)));
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(21, 173, 153,1),
                              textStyle: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700,fontFamily: 'Montserrat'),
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15)),
                          child: const Text('Agregar sello')),
                    ),
                        const SizedBox(height: 30,),
                      ],
                    )
                )
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> stampList(int counter) {
  List<Widget> list = [];

  Widget widget = Container(
    padding: const EdgeInsets.all(5),
    height: 55,
    width: 55,
    decoration: BoxDecoration(
      border: Border.all( //<-- SEE HERE
          width: 5,
          color: const Color.fromRGBO(25, 60, 52,1)
      ),
      borderRadius: BorderRadius.circular(100),
    ),
    child: Image.asset('assets/images/stamps/stampGreen.png'),
  );

  Widget widgetFalse = Container(
    padding: const EdgeInsets.all(6),
    height: 55,
    width: 55,
    decoration: BoxDecoration(
      border: Border.all( //<-- SEE HERE
          width: 5,
          color: const Color.fromRGBO(150, 150, 150,1)
      ),
      borderRadius: BorderRadius.circular(100),
    ),
    child: Image.asset('assets/images/stamps/stampGrey.png'),
  );

  for (var i = 0; i < counter; i++) {
    list.add(widget);
  }

  for(var i = 0; i < (12-counter); i++){
    list.add(widgetFalse);
  }
  return list;
}
