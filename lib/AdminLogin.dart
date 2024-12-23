import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AdminDashBoard.dart';
import 'login.dart'; // Import the LoginPage

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  String? errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    try {
      // Replace Firebase auth logic with admin-specific logic
      // Example: Authenticate using admin credentials (modify this to your needs)
      if (_idController.text.trim() == "admin" && _passwordController.text.trim() == "admin123") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashBoard()),
        );
      } else {
        setState(() {
          errorMessage = "Invalid Admin ID or Password.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFE989BE),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to the LoginPage when back button is pressed
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()), // Navigate to LoginPage
              );
            },
          ),
          title: Text(
            'Welcome Admin',
            style: GoogleFonts.balooTamma2(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFF4F9FD),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity, // Ensures the container fills the screen
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
                      'Welcome Admin',
                      style: GoogleFonts.pacifico(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF4F9FD),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (errorMessage != null)
                      Text(
                        errorMessage!,
                        style: GoogleFonts.balooTamma2(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _idController,
                      decoration: InputDecoration(
                        labelText: 'Admin ID',
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
                      obscureText: !_passwordVisible,
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xFFE989BE),
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE989BE),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.balooTamma2(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
