import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../main.dart';
import '../../../../models/coupon model.dart';
import 'coupons_item.dart';

class ClientCupons extends StatelessWidget {
  const ClientCupons({super.key});

  @override
  Widget build(BuildContext context) {
    List<CouponModel> allcoupons = [];
    return BlocBuilder<ReadUserCubit, ReadUser>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                foregroundColor: Colors.black87,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  "Cupones",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 20),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Coupons').where('email', isEqualTo: state.userModel.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Ah ocurrido un error'));
                      }
                      if (snapshot.hasData) {
                        allcoupons = snapshot.data!.docs
                            .map((doc) =>
                            CouponModel.fromJson(
                                doc as DocumentSnapshot<Map<String, dynamic>>))
                            .toList();

                        return ListView.builder(
                            itemCount: allcoupons.length,
                            itemBuilder: (context, index) {
                              return CouponCard(couponModel: allcoupons[index]);
                            }
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                ),
              )
          );
        }
    );
  }
}

class CouponCard extends StatelessWidget {
  final CouponModel couponModel;
  const CouponCard({super.key, required this.couponModel,});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientCouponItem(couponModel: couponModel)));
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical:10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 225, 208, 1),
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/cupon_coffe.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(couponModel.name,style :const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text('Cantidad: 1',style :TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.black54))
                    ],
                  ),
                ],
              ),
              const Icon(Icons.arrow_circle_right_outlined,size: 30,color: Colors.black54,)
            ],
          ),
        ),
      ),
    );
  }
}

