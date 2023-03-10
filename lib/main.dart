import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const myLoginPage(),
    );
  }
}

class myLoginPage extends StatelessWidget{
  const myLoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: Colors.lightGreen,

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText(text: "Welcome",fontsize: 40,color: Colors.white,),
              customSizedBox(screenHeight * 0.01),
              customText(text: "Log In to Continue", fontsize: 24,color: Colors.white,),
              customSizedBox(screenHeight * 0.01),
              TextFormField(
                decoration: CustomInputDecoration("Username"),
              ),
              customSizedBox(screenHeight * 0.01),
              TextFormField(
                decoration: CustomInputDecoration("Password"),
              ),
              customSizedBox(screenHeight * 0.02),
              TextButton(onPressed: () {}, child: customText(text: "forgot password?", fontsize: 16,color: Colors.black,)),
              customSizedBox(screenHeight * 0.07),
              customButton(screenHeight: screenHeight, screenWidth: screenWidth),
              customSizedBox(screenHeight * 0.20),
              TextButton(onPressed: () {}, child: customText(text: " Create Account", fontsize: 20,color: Colors.black,)),

            ],
          ),
        ),
      ),
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

class customButton extends StatelessWidget {
  const customButton({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
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
      onTap: (){},
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