
import 'package:denme/pages/auth/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

InkWell CustomLogInButton(double screenHeight, double screenWidth, GlobalKey<FormState> formkey, FirebaseAuth firebaseAuth, String email, String password, BuildContext context) {
    return InkWell(
    child: Container(
      height: screenHeight * 0.07,
      width: screenWidth * 0.7,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Center(child: customText(text: "Log In", fontsize: 24, color: Colors.white)),
    ),
    onTap: () async {
      if(formkey.currentState!.validate()){
        formkey.currentState!.save();
        try {
          final userResult = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
          print(userResult.user!.email);
          Navigator.pushNamed(context, "/homepage");
        } catch (e) {
          print(e.toString());
        }
      }
    },
  );
  }