import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:second_app/src/routing/main_%20employee/subscription.dart';
import 'package:second_app/src/routing/main_%20employee/profile.dart';
import 'regular_client.dart';
import 'coupons.dart';

class EmployeeMain extends StatefulWidget {
  const EmployeeMain({Key? key}) : super(key: key);

  @override
  _MainScreenEmployeee createState() => _MainScreenEmployeee();
}

class _MainScreenEmployeee extends State<EmployeeMain> {
  int currentScreen = 0;
  List<Widget> screenView = [
    const EmployeeRegularClient(),
    const EmployeeCoupons(),
    const EmployeeSubscription(),
    const EmployeeProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final value = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: const Text('¿Deseas salir?'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('No')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Si')),
                    ]);
              });
          if (value != null) {
            return Future.value(value);
          } else {
            return Future.value(false);
          }
        },
        child: Scaffold(
          body: screenView[currentScreen],
          bottomNavigationBar: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: GNav(
                color: Colors.grey,
                activeColor: Colors.white,
                tabBackgroundColor: const Color.fromRGBO(25, 60, 52, 1),
                gap: 8,
                onTabChange: (index) {
                  setState(() {
                    currentScreen = index;
                  });
                },
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                tabs: const [
                  GButton(
                    icon: Icons.supervised_user_circle_sharp,
                    text: 'Sellos',
                  ),
                  GButton(
                    icon: Icons.workspace_premium,
                    text: 'Cupones',
                  ),
                  GButton(
                    icon: Icons.shopping_bag,
                    text: 'Subscripción',
                  ),
                  GButton(
                    icon: Icons.supervised_user_circle_outlined,
                    text: 'Perfil',
                  )
                ]),
          ),
        ));
  }
}
