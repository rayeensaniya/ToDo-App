import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, required this.onpPressed, required this.text,this.width,this.backgroundColor,this.textColor})
      : super(key: key);
  final Function() onpPressed;
  final String text;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: width??double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor:backgroundColor?? Colors.black,),
        onPressed: onpPressed,
        child: Text(
          text,
          style:  TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: textColor??Colors.white),
        ),
      ),
    );
  }
}
