import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
 const AppTextField({super.key,required this.labelText,this.validator,
   this.readOnly,
   this.onTp,
   this.maxLength,
   this.filled,
    this.hinText,
   this.keyboardType,
   this.onFieldSubmitted,
   this.maxLines,
   this.focusNode,
   this.suffixIcon,
   this.alignLabelWithHint,
   this.isSecure = false,
   this.controller});
 final String? hinText;
 final Function(String)? onFieldSubmitted;
 final FocusNode? focusNode;
 final TextInputType? keyboardType;
 final String labelText;
 final bool isSecure;
 final Icon? suffixIcon;
 final bool? readOnly;
 final int? maxLength;
 final Function()? onTp;
 final String? Function(String?)? validator;
 final TextEditingController? controller;
 final int? maxLines;
 final bool? alignLabelWithHint;
 final bool? filled;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly??false,
      obscureText: widget.isSecure,
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode:widget.focusNode ,
      maxLength: widget.maxLength,
      controller: widget.controller,
      maxLines: widget.maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      onTap:widget.onTp ,
      decoration: InputDecoration(
        alignLabelWithHint: widget.alignLabelWithHint,
        suffixIcon: widget.suffixIcon,
        hintText: widget.hinText,
        labelText: widget.labelText,
     filled: widget.filled??false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
