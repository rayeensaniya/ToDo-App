import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, required this.onpPressed, required this.text})
      : super(key: key);
  final Function() onpPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, fixedSize: const Size(350, 60)),
      onPressed: onpPressed,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
