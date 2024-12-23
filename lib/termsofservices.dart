import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class termsofservices extends StatelessWidget {
  const termsofservices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Terms of Service',
            style: GoogleFonts.pacifico(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Placeholder for gradient
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE989BE), Color(0xFFEDFFC3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF4F9FD), Color(0xFFE1EAF5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terms of Service',
                  style: GoogleFonts.balooTamma2(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome to [App Name]! By using our application, you agree to the following terms and conditions. Please read them carefully.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF3B3B3B),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                buildSection(
                  title: '1. User Responsibilities',
                  content:
                  'Users must ensure that all information provided during registration or usage is accurate and up-to-date. Users agree to use the app for lawful purposes only.',
                ),
                buildSection(
                  title: '2. Privacy Policy',
                  content:
                  'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your data.',
                ),
                buildSection(
                  title: '3. Prohibited Activities',
                  content:
                  'You may not use our app to engage in fraudulent activities, distribute harmful content, or violate any applicable laws and regulations.',
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00B4DB),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'I Acknowledge',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.balooTamma2(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF005082),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF3B3B3B),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
