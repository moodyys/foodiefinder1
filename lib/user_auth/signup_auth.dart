import 'package:firebase_auth/firebase_auth.dart';

class signup_auth{
  FirebaseAuth _auth =  FirebaseAuth.instance;
  Future<User?> signUpWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential credential= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;

    }
    catch(e){
      print("some error occured");
    }
    return null;


  }

}
