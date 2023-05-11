import 'package:flutter/material.dart';
import 'package:second_app/src/routing/main_client/main_routing/home/qr%20screens/create_coupon.dart';

import '../../../../models/coupon model.dart';

class ClientCouponItem extends StatelessWidget {
  final CouponModel couponModel;

  const ClientCouponItem({super.key, required this.couponModel});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: const Color.fromRGBO(233, 225, 208,1),
        appBar: AppBar(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Cupón",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xfffbefdf), Color(0xffe9e1d0)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )
          ),
          padding: const EdgeInsets.symmetric(vertical: 35,horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  const Text('Cupón',style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                  Text(couponModel.name,style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),),
                  const Text('cantidad 1',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                ],
              ),
              Image(
                image: const AssetImage('assets/images/cupon_coffe.png'),
                width: MediaQuery.of(context).size.width*0.7,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClientCreateCoupon(couponModel: couponModel,)));
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(25, 60, 52, 1),
                      textStyle: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w700,fontFamily: 'Montserrat'),
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15)),
                  child: const Text('Redimir'),
                ),
              ),
            ],
          ),
        ));
  }
}

// SizedBox(
//                           width: double.infinity,
//                           child: OutlinedButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => ClientCreateCoupon(couponModel: couponModel)));
//                               },
//                               style: OutlinedButton.styleFrom(
//                                   backgroundColor: const Color.fromRGBO(25, 60, 52, 1),
//                                   textStyle: const TextStyle(
//                                       fontSize: 17, fontWeight: FontWeight.w700,fontFamily: 'Montserrat'),
//                                   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
//                                   foregroundColor: Colors.white,
//                                   padding: const EdgeInsets.symmetric(vertical: 15)),
//                               child: const Text('Redimir')),
//                         ),
