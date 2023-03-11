


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget{
   SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String email,password;

  final formkey = GlobalKey<FormState>();
  final firebaseauth = FirebaseAuth.instance;
  
  
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.lightGreen,

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Form(
          key: formkey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(text: "Welcome",fontsize: 40,color: Colors.white,),
                customSizedBox(screenHeight * 0.01),
                customText(text: "Sign Up to Continue", fontsize: 24,color: Colors.white,),
                customSizedBox(screenHeight * 0.01),
                emailTextField(),
                customSizedBox(screenHeight * 0.01),
                passwordTextField("password"),
                customSizedBox(screenHeight * 0.15),
                signUpButton(screenHeight, screenWidth),
                customSizedBox(screenHeight * 0.01),
                TextButton(onPressed: () => Navigator.pushNamed(context, "/loginpage"), child: customText(text: "do you have already an account? Sign In", fontsize: 15, color: Colors.white)),
        
        
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell signUpButton(double screenHeight, double screenWidth) {
    return InkWell(
    child: Container(
      height: screenHeight * 0.07,
      width: screenWidth * 0.7,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Center(child: customText(text: "Sign Up", fontsize: 24, color: Colors.white)),
    ),
    onTap: () async {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();
        try {
        var userResult = await firebaseauth.createUserWithEmailAndPassword(email: email, password: password);
        print(userResult.user!.uid);
        formkey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You have signed up, please log in now")));
        Navigator.pushNamed(context, "/loginpage");
        } catch (e) {
          print(e.toString());
        }
      }
    },
  );
  }

  TextFormField passwordTextField(String string) {
    return TextFormField(
              validator: (value) {
                if(value!.isEmpty){
                  return "lütfen parolanızı giriniz";
                }
              },
              onSaved: (newValue) {
                password = newValue!;
              },
              obscureText: true,
              style: TextStyle(color: Colors.white),
              
              decoration: CustomInputDecoration(string),
            );
  }

  TextFormField emailTextField() {
    return TextFormField(
              validator: (value) {
                if (value!.isEmpty){
                  return "Lütfen bilgileri eksiksiz doldurunuz";
                }
              },

              onSaved: (newValue) {
                email = newValue!;
              },
              style: TextStyle(color: Colors.white),
              decoration: CustomInputDecoration("email"),
            );
  }

  InputDecoration CustomInputDecoration(String hinttext) {
    return InputDecoration(
                
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide( color:  Colors.white)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
                ),
                hintText: hinttext,
                hintStyle: TextStyle(color: Colors.white)
              );
  }
}



Widget customSizedBox(double height) => SizedBox(height: height);
class customText extends StatelessWidget {
  const customText({
    super.key,
    required this.text,
    required this.fontsize, required this.color
  });


  final String text;
  final double fontsize;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: fontsize,color: color),);
  }
}