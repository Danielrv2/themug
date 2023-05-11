import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "términos y condiciones",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Beneficios de suscripción',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),),
              SizedBox(
                height:10,
              ),
              Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400,height: 1.5)),
              SizedBox(
                height: 20,
              ),
              Text('Cliente frecuente',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              SizedBox(
                height:5,
              ),
              Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400,height: 1.5)),
            ],
          ),
        ),
      )
    );
  }
}
