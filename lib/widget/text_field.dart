import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
 const AppTextField({super.key,required this.labelText,this.validator,
   this.maxLength,
    this.hinText,
   this.keyboardType,
   this.onFieldSubmitted,
   this.focusNode,
   this.suffixIcon,
   this.obsecureText = false,
   this.controller});
 final String? hinText;
 final Function(String)? onFieldSubmitted;
 final FocusNode? focusNode;
 final TextInputType? keyboardType;
 final String labelText;
 final bool obsecureText;
 final Icon? suffixIcon;
 final int? maxLength;
 final String? Function(String?)? validator;
 final TextEditingController? controller;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      keyboardType: widget.keyboardType,
      obscureText: widget.obsecureText,
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode:widget.focusNode ,
      maxLength: widget.maxLength,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        hintText: widget.hinText,
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
