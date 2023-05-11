import 'package:flutter/material.dart';
import '../models/stamps_model.dart';
import '../routing/main_ employee/qr/create_stamp.dart';


Object showAlert(String title,String body,BuildContext context){
  return showDialog(
      context:context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Si')),
        ],
      )
  );
}

confirmationScan(String title,String body,BuildContext context){
  return showDialog(
      context:context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w600,letterSpacing: 1.5),),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Si')),
        ],
      )
  );
}



class ConfirmDialog extends StatelessWidget{
  final String title;
  final String body;
  final BuildContext context;

  const ConfirmDialog({super.key, required this.title, required this.body, required this.context});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          child: const Text('No'),
          onPressed: (){
            Navigator.pop(context);},
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromRGBO(160, 215, 205, 1),
            ),
            onPressed: () async {
              try{
                var date = DateTime.now();
                var code = await addStamp(date);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  EmployeCreateStamp(data:code)));
              }catch(err){
                showAlert('Error', 'Ha ocurrido un error inténtelo de nuevo', context);
                Navigator.pop(context);
              }
            },
            child: const Text('Si'))
      ],
      elevation: 24,
      backgroundColor: Colors.white,
    );
  }
}

showConfirmationDialog(BuildContext context,String body){
  const String title = 'Confirmación';
  showDialog(
    context: context,
    builder: (context) => ConfirmDialog(title: title, body: body,context: context),
    barrierDismissible: false,
  );
}