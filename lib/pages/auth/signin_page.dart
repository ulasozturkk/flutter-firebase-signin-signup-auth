


import 'package:denme/service/auth_service.dart';
import 'package:denme/widgets/custom_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class myLoginPage extends StatefulWidget{
  const myLoginPage({super.key});

  @override
  State<myLoginPage> createState() => _myLoginPageState();
}

class _myLoginPageState extends State<myLoginPage> {

    
    late String email,password;
    final formkey = GlobalKey<FormState>();
    final firebaseAuth = FirebaseAuth.instance;
    final authService = AuthService(); 

  @override
  
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.lightGreen,
      body: appBody(screenWidth, screenHeight, context),
    );
  }

  Padding appBody(double screenWidth, double screenHeight, BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Form(
        key: formkey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const WelcomeText(),
              customSizedBox(screenHeight * 0.01),
              const LogInToText(),
              customSizedBox(screenHeight * 0.01),
              emailTextFieldd(),
              customSizedBox(screenHeight * 0.01),
              passwordTextFieldd(),
              customSizedBox(screenHeight * 0.02),
              const ForgotPasswordButton(),
              customSizedBox(screenHeight * 0.07),
              SignInButton(screenHeight, screenWidth),
              customSizedBox(screenHeight * 0.20),
              const CreateAccountButton(),
              SignInAnonymousButton(authService: authService)
            ],
          ),
        ),
      ),
    );
  }

  TextFormField passwordTextFieldd() {
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

  TextFormField emailTextFieldd() {
    return TextFormField(
  validator: (value) {
    if (value!.isEmpty) {
      return "Please Enter Your Valid Email!";
    } 
  },
  onSaved: (value) {
    email = value!;
  },
  style: const TextStyle(color: Colors.white),
  decoration: CustomInputDecoration("Email"),
 );
   }

  InkWell SignInButton(double screenHeight, double screenWidth) {
    return InkWell(
    onTap:signIn,
    child: Container(
      height: screenHeight * 0.07,
      width: screenWidth * 0.7,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20)
      ),
      child: const Center(child: customText(text: "Log In", fontsize: 24, color: Colors.white)),
    ),
  );
  }
  void signIn () async {
        if(formkey.currentState!.validate()){
          formkey.currentState!.save();
          try {
            final userResult = await AuthService().signIn;
            Navigator.pushNamed(context, "/homepage");
          } catch (e) {
            print(e.toString());
          }
        }
      }
}

class SignInAnonymousButton extends StatelessWidget {
  const SignInAnonymousButton({
    super.key,
    required this.authService,
  });

  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(onPressed: () {
      authService.signInAnonymous();
      Navigator.pushNamed(context, "/homepage");
    } , buttonText: "sign in anonymously", textColor: Colors.white, fontSize: 20);
  }
}

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(onPressed: () => Navigator.pushNamed(context, "/signup"), buttonText: "Create Account", 
    textColor: Colors.black, 
    fontSize: 20);
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {}, child: const customText(text: "forgot password?", fontsize: 16,color: Colors.black,));
  }
}

class LogInToText extends StatelessWidget {
  const LogInToText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const customText(text: "Log In to Continue", fontsize: 24,color: Colors.white,);
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const customText(text: "Welcome",fontsize: 40,color: Colors.white,);
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

  