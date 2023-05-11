// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:second_app/src/models/subscription_model.dart';
import 'package:second_app/src/routing/main_client/main_routing/home/qr%20screens/create_sub_coffe.dart';
import 'package:second_app/src/utils/dialogs.dart';
import '../../../../models/subscriptionCoffee.dart';

String benefis =
    'Como beneficios de subscripción tienes derecho a 20 cafés, los cuales puedes consumir a lo largo del mes';

class SubscriptionHome extends StatelessWidget {
  final SubscriptionModel subscriptionModel;

  const SubscriptionHome({super.key, required this.subscriptionModel});

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
          "Subscripción",
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
                    image: AssetImage('assets/images/covers/subscription.jpg')),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height * 0.60,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
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
                    const Text(
                      "Beneficios",
                      style: TextStyle(
                          color: Color.fromRGBO(40, 40, 40, 1),
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(benefis,
                        style: const TextStyle(
                            color: Color.fromRGBO(130, 130, 130, 1),
                            height: 1.4,
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Cafés",
                      style: TextStyle(
                          color: Color.fromRGBO(40, 40, 40, 1),
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Disponibles",
                              style: TextStyle(
                                  color: Color.fromRGBO(40, 40, 40, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color.fromRGBO(129, 199, 189, 1),
                                  width: 4,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text('${subscriptionModel.nCoffee}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(129, 199, 189, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "Canjeados",
                              style: TextStyle(
                                  color: Color.fromRGBO(40, 40, 40, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color.fromRGBO(150, 150, 150, 1),
                                  width: 4,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text('${10 - subscriptionModel.nCoffee}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(150, 150, 150, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () async {
                            if (subscriptionModel.coffeeStatus == null) {
                              try {
                                var idsubscriptionCoffee = await addSubscriptionCoffee(subscriptionModel);
                                updateCoffeeStatus(subscriptionModel, idsubscriptionCoffee);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ClientCreateSubsCoffee(idSucriptionCoffee: idsubscriptionCoffee,)));
                              } catch (e) {
                                showAlert(
                                    'Error',
                                    'Ha ocurrido un error intentelo de nuevo',
                                    context);
                              }
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ClientCreateSubsCoffee(
                                              idSucriptionCoffee:
                                                  subscriptionModel
                                                      .coffeeStatus!)));
                            }
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
                              textStyle: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Montserrat'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15)),
                          child: const Text('Redimir')),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ))),
          ),
        ],
      ),
    );
  }
}
