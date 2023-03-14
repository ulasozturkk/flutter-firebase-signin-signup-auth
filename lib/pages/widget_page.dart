

import 'package:denme/pages/auth/signin_page.dart';
import 'package:flutter/material.dart';

class SingInWidgets {
  static TextFormField passwordTextFieldd(String password) {
    return TextFormField(
          validator: (value) {
            if(value!.isEmpty){
              return "please enter your valid password!";
            }
          },
          onSaved: (newValue) {
            password = newValue!;
          },
          style: const TextStyle(color: Colors.white),
          
          decoration: CustomInputDecoration("Password"),
        );
  }
}