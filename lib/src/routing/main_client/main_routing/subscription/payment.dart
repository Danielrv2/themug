import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:second_app/src/utils/dialogs.dart';

import '../../../../models/subscription_model.dart';
import '../../main_client.dart';

class PaymentSusbscription extends StatefulWidget {

  final SubscriptionModel subscriptionModel;

  PaymentSusbscription(this.subscriptionModel, {super.key});

  final cardNumberMaskForm = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final expiratedDateMaskForm = MaskTextInputFormatter(
      mask: '##/##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final cvvMaskForm = MaskTextInputFormatter(
      mask: '###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  _PaymentSusbscriptionState createState() => _PaymentSusbscriptionState();
}

class _PaymentSusbscriptionState extends State<PaymentSusbscription> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;
  late FocusNode _focusNode;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController nameCardCtrl = TextEditingController();
  TextEditingController cvvCardCtrl = TextEditingController();
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Pago",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            CreditCard(
              cardNumber: cardNumber,
              cardExpiry: expiryDate,
              cardHolderName: cardHolderName,
              cvv: cvv,
              bankName: 'Banco',
              showBackSide: showBack,
              backTextColor: const Color(0xFFFFFFFF),
              frontBackground: CardBackgrounds.custom(0xFF81C7BD),
              backBackground: CardBackgrounds.custom(0xFF81C7BD),
              // mask: getCardTypeMask(cardType: CardType.americanExpress),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Form(
                      key: _keyForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Numero de tarjeta',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(120, 120, 120, 1),
                            ),
                          ),
                          TextFormField(
                            style: const TextStyle(
                              fontSize: 18,
                              wordSpacing: 6,
                            ),
                            controller: cardNumberCtrl,
                            enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: 'XXXX XXXX XXXX XXXX',
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(180, 180, 180, 1),
                              ),
                            ),
                            inputFormatters: [widget.cardNumberMaskForm],
                            onChanged: (value) {
                              setState(() {
                                cardNumber = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El campo esta vacio';
                              } else if (value.length != 19) {
                                return 'El campo esta incompleto';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Nombre',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(120, 120, 120, 1),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nameCardCtrl,
                            onChanged: (value) {
                              setState(() {
                                cardHolderName = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El campo esta vacio';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Fecha exp.',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(120, 120, 120, 1),
                                    ),
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                        fontSize: 18,),
                                    controller: expiryFieldCtrl,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                      hintText: 'MM/YY',
                                      hintStyle: TextStyle(
                                        color: Color.fromRGBO(180, 180, 180, 1),
                                      ),
                                    ),
                                    inputFormatters: [
                                      widget.expiratedDateMaskForm
                                    ],
                                    keyboardType: TextInputType.phone,
                                    onChanged: (value) {
                                      setState(() {
                                        expiryDate = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'vacio';
                                      } else if (value.length != 5) {
                                        return 'incompleto';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              )),
                              const SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'CVV',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(120, 120, 120, 1),
                                    ),
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                      hintText: 'XXX',
                                      hintStyle: TextStyle(
                                        color: Color.fromRGBO(180, 180, 180, 1),
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [widget.cvvMaskForm],
                                    onChanged: (value) {
                                      setState(() {
                                        cvv = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'vacio';
                                      } else if (value.length != 3) {
                                        return 'incompleto';
                                      } else {
                                        return null;
                                      }
                                    },
                                    focusNode: _focusNode,
                                  ),
                                ],
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black54,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Producto',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(80, 80, 80, 1)),
                          ),
                          Text(
                            'Precio',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(80, 80, 80, 1)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Suscripcion (1 mes)',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                        Text(
                          r'25.00$',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.black54,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Total',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          Text(
                            r'25.00 $',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            try{
                              paySubscription(widget.subscriptionModel);
                              final snackBar = SnackBar(
                                duration: const Duration(milliseconds: 1500),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(92, 184, 92,1),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.check_circle,weight: 20,color: Colors.white),
                                      SizedBox(width: 20,),
                                      Text('Subscripcion completa',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.w500),)
                                    ],
                                  ),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => const MainClient()
                                  ),(route)=> false
                              );
                            }catch(e){
                              showAlert('Error', 'Ha ocurrido un error, verefique sus datos o su conexion a internet', context);
                            }
                          }
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(255, 68, 56, 1),
                            textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15)),
                        child: const Text('Pagar'),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
