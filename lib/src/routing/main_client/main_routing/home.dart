import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';
import '../../../models/regular_client_model.dart';
import '../../../models/subscription_model.dart';
import '../terms_conditions.dart';
import 'home/home_regular_client.dart';
import 'home/home_subscription.dart';

class ClientHome extends StatelessWidget {
  const ClientHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadUserCubit, ReadUser>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: Colors.black87,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Inicio",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                    future: getRegularClientId(state.userModel.idRegularClient),
                    builder: (_, AsyncSnapshot<RegularClientModel> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        RegularClientModel regularClient = snapshot.data!;
                        return RegularClientCard(regularClient: regularClient);
                      } else {
                        return const Text('Error de conexion');
                      }
                    }),
                FutureBuilder(
                    future: getSubscriptionId(state.userModel.idSubscription),
                    builder: (_, AsyncSnapshot<SubscriptionModel> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        SubscriptionModel subscriptionModel = snapshot.data!;
                        if (subscriptionModel.nBuys == 0) {
                          return const SizedBox(height: 0);
                        } else {
                          return SubscriptionCard(
                              subscriptionModel: subscriptionModel);
                        }
                      } else {
                        return const Text('Error de conexion');
                      }
                    }),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TermsAndConditions()));
                    },
                    child: const Text(
                      'Ver términos y condiciones',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          )
        ),
      );
    });
  }
}

class RegularClientCard extends StatelessWidget {
  const RegularClientCard({
    super.key,
    required this.regularClient,
  });

  final RegularClientModel regularClient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ClientHomeRegularClient(regularClient: regularClient)));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        height: 230,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: const DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                image: AssetImage('assets/images/covers/RegularClient.jpg'))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tarjeta Cliente frecuente',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            Text('${regularClient.counter}-12',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white))
          ],
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.subscriptionModel,
  });

  final SubscriptionModel subscriptionModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubscriptionHome(
                      subscriptionModel: subscriptionModel,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        height: MediaQuery.of(context).size.width*0.9,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/covers/subscription.jpg'))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tarjeta Subscripción',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            Text('Disponible: ${subscriptionModel.nCoffee}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
