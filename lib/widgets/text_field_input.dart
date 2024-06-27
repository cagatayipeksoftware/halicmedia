import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Icon icon;
  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.icon,
      this.isPass=false,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context),borderRadius: BorderRadius.circular(30));
    return TextField(
      style: TextStyle(color: Colors.white),
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        fillColor: Colors.black,hintStyle: TextStyle(color: Colors.white,),
        
      ),
      keyboardType: textInputType,
            obscureText: isPass,
    );
  }
}
