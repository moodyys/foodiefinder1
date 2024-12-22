import 'package:flutter/material.dart';

class termsofservices extends StatelessWidget {
  const termsofservices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Text(
                'Terms of Service',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 16),
              // Introduction Section
              const Text(
                'Welcome to [App Name]! By using our application, you agree to the following terms and conditions. Please read them carefully.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              // Terms Section
              buildSection(
                title: '1. User Responsibilities',
                content:
                'Users must ensure that all information provided during registration or usage is accurate and up-to-date. Users agree to use the app for lawful purposes only.',
              ),
              const SizedBox(height: 16),
              buildSection(
                title: '2. Privacy Policy',
                content:
                'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your data.',
              ),
              const SizedBox(height: 16),
              buildSection(
                title: '3. Prohibited Activities',
                content:
                'You may not use our app to engage in fraudulent activities, distribute harmful content, or violate any applicable laws and regulations.',
              ),
              const SizedBox(height: 16),
              buildSection(
                title: '4. Intellectual Property',
                content:
                'All content, trademarks, and logos displayed in the app are the property of [App Name] or third-party licensors. Unauthorized use is strictly prohibited.',
              ),
              const SizedBox(height: 16),
              buildSection(
                title: '5. Liability Limitation',
                content:
                'We are not liable for any damages arising from the use or inability to use our app. Your use of the app is at your own risk.',
              ),
              const SizedBox(height: 16),
              buildSection(
                title: '6. Amendments',
                content:
                'We reserve the right to update these terms at any time. Continued use of the app indicates your acceptance of the updated terms.',
              ),
              const SizedBox(height: 20),
              // Conclusion Section
              Text(
                'Thank you for using [App Name]. If you have any questions or concerns, please contact us at support@appname.com.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              // Acknowledgement Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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
    );
  }

  // Helper function to build a styled section
  Widget buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
