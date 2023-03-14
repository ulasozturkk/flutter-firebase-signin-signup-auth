
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final firebaseauth = FirebaseAuth.instance;
  final Firebasefirestore = FirebaseFirestore.instance;

  Future signInAnonymous() async {
    try {
      final result = firebaseauth.signInAnonymously();
      return result;
    } catch (e) {
      print("hata");
    }
  }

  Future<String?> signIn (String email,String password) async {
    String? res;

    try {
    final result = firebaseauth.signInWithEmailAndPassword(email: email, password: password);
    res = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-nofound") {
        res = "User not found!";
      }
      else if(e.code == "wrong-password"){
        res = "Wrong Password!";
      }
    }
    return res;
  }


  Future<String?> signUp(String email,String username,String fullname,String password) async {
    String? res;
    try {
      final result =await firebaseauth.createUserWithEmailAndPassword(email: email, password: password);
      try {
        final resultData = await Firebasefirestore.collection("users").add(
          {
            "email" :email,
            "username":username,
            "fullname":fullname,
            "posts": [],
            "followers":[],
            "following":[],
            "bio" : "",
            "website":""

          }
        );
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}