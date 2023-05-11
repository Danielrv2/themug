import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/src/routing/main_client/main_routing/subscription/payment.dart';
import '../../../../../main.dart';
import '../../../../models/subscription_model.dart';

class SuscriptionScreen extends StatelessWidget {
  const SuscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadUserCubit, ReadUser>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "Suscripción",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          body: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: const AssetImage('assets/images/membership.png'),
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  Column(
                    children: const [
                      Text(
                        'Beneficios',
                        style: TextStyle(
                            color: Color.fromRGBO(21, 173, 153, 1),
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        r'Suscríbete a nuestros y obtén 10 cafés de especialidad cada mes, Puedes canjear en nuestra sucursal. La suscripción tiene un costo de $25.00 dólares mensuales.',
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: getSubscriptionId(state.userModel.idSubscription),
                      builder: (_, AsyncSnapshot<SubscriptionModel> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          SubscriptionModel subscriptionModel = snapshot.data!;
                          DateTime expDate = subscriptionModel.lastBuy!['expDate'].toDate();
                          if ( DateTime.now().isAfter(expDate)) {
                            return SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentSusbscription(subscriptionModel)));
                                    },
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(21, 173, 153, 1.0),
                                        textStyle: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Montserrat'),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15)),
                                    child: const Text(r'Suscríbete por 25$')));
                          } else {
                            Duration diferentDay = expDate.difference(DateTime.now());
                            return Column(
                              children: [
                                SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                        onPressed: () {
                                        },
                                        style: OutlinedButton.styleFrom(
                                            backgroundColor: Colors.black87,
                                            textStyle: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Montserrat'),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(15)),
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15)),
                                        child: const Text('Ya estas suscrito'))),
                                const SizedBox(height: 10),
                                Text('Restan ${(diferentDay.inHours/24).round()} dias de Suscripción', style: const TextStyle(fontWeight: FontWeight.w500,color:Colors.black54,fontSize: 16),)
                              ],
                            );
                          }
                        } else {
                          return const Text('Error de conexion');
                        }
                      }),
                ],
              )));
    });
  }
}
