import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'favorites.dart';
import 'ManageMyReviews.dart';
import 'editprofile.dart';
import 'termsofservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class myaccount extends StatelessWidget {
   myaccount({Key? key}) : super(key: key);

  final User? currentuser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(currentuser!.email)
        .get();
  }


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
            'My Account',
            style: GoogleFonts.lilyScriptOne(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white70, // Placeholder for gradient
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
      body:
    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDetails(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    }

    if (snapshot.hasError) {
    return const Center(
    child: Text('An error occurred!'),
    );
    }

    if (!snapshot.hasData || snapshot.data!.data() == null) {
    return const Center(
    child: Text('No user data found!'),
    );
    }

    // Extract user data
    final user = snapshot.data!.data()!;
    final email = user!['useremail'];
    final username=user['username'];

     return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF4F9FD), Color(0xFFE1EAF5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with profile picture
              Container(
                height: 220,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE989BE), Color(0xFFEDFFC3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              // User Info Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: GoogleFonts.balooTamma2(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      email,
                      style: GoogleFonts.balooTamma2(
                        fontSize: 16,
                        color: const Color(0xFF888888),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Your Account',
                      style: GoogleFonts.balooTamma2(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333),
                      ),
                    ),
                  ],
                ),
              ),
              // Account Options
              _buildOptionTile(
                context,
                title: 'Profile Settings',
                icon: Icons.settings,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const editprofile()),
                  );
                },
              ),
              _buildOptionTile(
                context,
                title: 'Manage Reviews',
                icon: Icons.reviews_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Managemyreviews()),
                  );
                },
              ),
              _buildOptionTile(
                context,
                title: 'Favorites',
                icon: Icons.favorite,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const favorites()),
                  );
                },
              ),
              _buildOptionTile(
                context,
                title: 'Terms of Service',
                icon: Icons.privacy_tip_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const termsofservices()),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Logout Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add your logout logic here
                    print('User logged out');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.balooTamma2(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    ),
    );
  }
  // Helper method to build account options
  Widget _buildOptionTile(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFFE989BE), size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.balooTamma2(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF222222),
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Color(0xFF888888)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}