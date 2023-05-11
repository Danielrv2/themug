import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'main_routing/coupons/coupons.dart';
import 'main_routing/home.dart';
import 'main_routing/subscription/subscription.dart';
import 'main_routing/profile.dart';

class MainClient extends StatefulWidget {
  const MainClient({Key? key}) : super(key: key);

  @override
  MainClientState createState() => MainClientState();
}

class MainClientState extends State<MainClient> {
  int currentScreen = 0;
  List<Widget> screenView = [
    const ClientHome(),
    const ClientCupons(),
    const SuscriptionScreen(),
    UserScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog(context: context, builder: (context){
          return  AlertDialog(
            title: const Text('¿Deseas salir?'),
            actions:
            [
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop(false);
                }, child: const Text('No')),
              ElevatedButton(onPressed:(){
                Navigator.of(context).pop(true);
              } , child: const Text('Si')),
            ]
          );
        });
        if(value!= null ){
          return Future.value(value);
        }else{
          return Future.value(false);
        }
      },
      child: Scaffold(
          body: screenView[currentScreen],
          bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),),
                  color: Color.fromRGBO(255, 255, 255, 1)),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              child: GNav(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  iconSize: 26,
                  color: const Color.fromRGBO(160, 160, 160, 1),
                  activeColor: Colors.white,
                  tabBackgroundColor: const Color.fromRGBO(255, 68, 56, 1),
                  gap: 8,
                  onTabChange: (index) {
                    setState(() {
                      currentScreen = index;
                    });
                  },
                  padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Inicio',
                    ),
                    GButton(
                      icon: Icons.workspace_premium,
                      text: 'Cupones',
                    ),
                    GButton(
                      icon: Icons.shopping_bag,
                      text: 'Suscripción',
                    ),
                    GButton(icon: Icons.account_circle, text: 'Perfil')
                  ]))),);
  }
}
