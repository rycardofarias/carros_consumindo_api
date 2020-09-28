import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;

  bool passoword;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboarType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;

  AppText(this.label, this.hint,{ this.passoword= false, this.controller,
      this.validator, this.keyboarType, this.textInputAction, this.focusNode,
      this.nextFocus,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: passoword,
      validator: validator,
      keyboardType: keyboarType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text){
        if(nextFocus!=null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
          fontSize: 25,
          color: Colors.blue
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4)
        ),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 25,
            color: Colors.grey,
          ),
          hintText: hint,
          hintStyle:  TextStyle(
              fontSize: 16
          )
      ),
    );
  }
}
