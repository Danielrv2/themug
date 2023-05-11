import 'package:flutter/material.dart';

class FlashMessage extends StatelessWidget {
  const FlashMessage({super.key, required this.message, required this.colorMessage});
  final Color colorMessage;
  final String message;
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 2,
      content: Container(
        padding: const EdgeInsets.all(16),
        height: 90,
        decoration: BoxDecoration(
          color: colorMessage,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle,weight: 20,color: Colors.white),
            Text(message,style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.w600),)
          ],
        ),
      ),
    );
  }
}
