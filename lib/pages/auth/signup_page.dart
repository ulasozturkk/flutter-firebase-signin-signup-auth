


import 'package:denme/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget{
   SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String email,password,username,fullname;

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
                const customText(text: "Welcome",fontsize: 40,color: Colors.white,),
                customSizedBox(screenHeight * 0.01),
                const customText(text: "Sign Up to Continue", fontsize: 24,color: Colors.white,),
                customSizedBox(screenHeight * 0.01),
                emailTextField(),
                customSizedBox(screenHeight * 0.01),
                fullnameTextField(),
                customSizedBox(screenHeight * 0.01),
                usernameTextfield(),
                customSizedBox(screenHeight * 0.01),
                passwordTextField(),
                customSizedBox(screenHeight * 0.15),
                signUpButton(screenHeight, screenWidth),
                customSizedBox(screenHeight * 0.01),
                TextButton(onPressed: () => Navigator.pushNamed(context, "/loginpage"), child: const customText(text: "do you have already an account? Sign In", fontsize: 15, color: Colors.white)),
        
        
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell signUpButton(double screenHeight, double screenWidth) {
    return InkWell(
    onTap: () {
      signUp();
      Navigator.pushNamed(context, "/loginpage");
    },
    child: Container(
      height: screenHeight * 0.07,
      width: screenWidth * 0.7,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20)
      ),
      child: const Center(child: customText(text: "Sign Up", fontsize: 24, color: Colors.white)),
    )
  );
  }

  void signUp() async {
    try {
      if(formkey.currentState!.validate()){
        formkey.currentState!.save();
        final result = await AuthService().signUp(email, username, fullname, password);
      }
    } catch (e) {
      
    }
  }
    

  TextFormField passwordTextField() {
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
              style: const TextStyle(color: Colors.white),
              
              decoration: CustomInputDecoration("password"),
            );
  }

  TextFormField usernameTextfield() {
    return TextFormField(
              validator: (value) {
                if(value!.isEmpty){
                  return "please enter your username";
                }
              },
              onSaved: (newValue) {
                username = newValue!;
              },
              
              style: const TextStyle(color: Colors.white),
              
              decoration: CustomInputDecoration("username"),
            );
  }

  TextFormField fullnameTextField() {
    return TextFormField(
              validator: (value) {
                if(value!.isEmpty){
                  return "please enter your full name";
                }
              },
              onSaved: (newValue) {
                fullname = newValue!;
              },
              
              style: const TextStyle(color: Colors.white),
              
              decoration: CustomInputDecoration("full name"),
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
              style: const TextStyle(color: Colors.white),
              decoration: CustomInputDecoration("email"),
            );
  }

  InputDecoration CustomInputDecoration(String hinttext) {
    return InputDecoration(
                
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide( color:  Colors.white)
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
                ),
                hintText: hinttext,
                hintStyle: const TextStyle(color: Colors.white)
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