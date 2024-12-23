import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodiefinder1/Userhomepage.dart';
import 'package:foodiefinder1/user_auth/signup_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart'; // Import LoginPage

class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({Key? key}) : super(key: key);

  @override
  State<CreateAccountWidget> createState() => _CreateAccountWidgetState();
}


class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  final signup_auth _auth = signup_auth();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE989BE),
        title: Text(
          'Create Account',
          style: GoogleFonts.balooTamma2(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF4F9FD),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE989BE), Color(0xFFEDFFC3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create a New Account',
                    style: GoogleFonts.pacifico(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF4F9FD),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Add form fields for account creation (e.g., Name, Email, Password)

                  TextField(
                    controller: _fullnameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: GoogleFonts.balooTamma2(
                        color: const Color(0xFFE989BE),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: GoogleFonts.balooTamma2(
                        color: const Color(0xFFE989BE),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.balooTamma2(
                        color: const Color(0xFFE989BE),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {_signUp();
                      // Navigate to LoginPage when "Create Account" is pressed
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const LoginPage()),
                      // );

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE989BE),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Create Account',
                      style: GoogleFonts.balooTamma2(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: GoogleFonts.balooTamma2(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign in here',
                          style: GoogleFonts.balooTamma2(
                            color: const Color(0xFFE989BE),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to LoginPage when "Sign in here" is pressed
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _signUp() async{
     String fullname = _fullnameController.text;
     String email = _emailController.text;
     String password = _passwordController.text;

     User? user = await _auth.signUpWithEmailAndPassword(email, password);

     if (user != null){
       print("User is successfully created");
       Navigator.pushNamed(context,"/userHomepage");
     }
     else{print("Some error Occured");}
  }
}
