import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyAndPolicyWidget extends StatefulWidget {
  const PrivacyAndPolicyWidget({super.key});

  @override
  State<PrivacyAndPolicyWidget> createState() => _PrivacyAndPolicyWidgetState();
}

class _PrivacyAndPolicyWidgetState extends State<PrivacyAndPolicyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy and Policy',
          style: GoogleFonts.bubblegumSans( // Updated to Bubblegum Sans
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set title color to white
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE989BE), Color(0xFF6A1B9A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3E5F5), Color(0xFFEDE7F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: GoogleFonts.bubblegumSans( // Updated to Bubblegum Sans
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome to our Privacy Policy page! At FoodieFinder, we value your privacy and are committed to protecting your personal data. Please read this policy carefully to understand how we collect, use, and safeguard your information.',
                style: GoogleFonts.bubblegumSans( // Updated to Bubblegum Sans
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              _buildSection(
                'Information We Collect',
                '1. Personal Data: Name, email address, and phone number (if provided).\n'
                    '2. Usage Data: Information about how you interact with the app, such as search history and location (if enabled).\n'
                    '3. Device Data: Device type, operating system, and app version.',
              ),
              _buildSection(
                'How We Use Your Data',
                '1. To personalize your experience and provide restaurant recommendations.\n'
                    '2. To improve app functionality and user experience.\n'
                    '3. To communicate updates, promotions, and changes to our services.',
              ),
              _buildSection(
                'Data Sharing and Security',
                '1. Your data is never sold to third parties.\n'
                    '2. Data is shared only with trusted partners to enhance app services (e.g., map integrations).\n'
                    '3. We implement encryption and secure storage to protect your information.',
              ),
              _buildSection(
                'Your Rights',
                '1. Access and Update: You can access and update your personal data at any time.\n'
                    '2. Delete: Request deletion of your data by contacting support.\n'
                    '3. Opt-Out: Disable data collection by adjusting app settings.',
              ),
              _buildSection(
                'Contact Us',
                'If you have any questions or concerns about this policy, please contact us at support@foodiefinder.com.',
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Back to Settings',
                    style: GoogleFonts.bubblegumSans( // Updated to Bubblegum Sans
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.bubblegumSans( // Updated to Bubblegum Sans
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.bubblegumSans( // Updated to Bubblegum Sans
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
