import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Changeusernamescreen extends StatefulWidget {
  const Changeusernamescreen({super.key});

  @override
  State<Changeusernamescreen> createState() => _ChangeusernamescreenState();
}

class _ChangeusernamescreenState extends State<Changeusernamescreen> {
  final TextEditingController _usernameTextController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();

  @override
  void dispose() {
    _usernameTextController.dispose();
    _usernameFocusNode.dispose();
    super.dispose();
  }

  Future<void> updateUsername(String newUsername) async {
    try {
      // Get the current user's email
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user is currently signed in.'),
          ),
        );
        return;
      }

      String userEmail = user.email!;

      // Update the username in the Firestore "users" collection
      await FirebaseFirestore.instance
          .collection('users')
          .where('useremail', isEqualTo: userEmail)
          .limit(1)
          .get()
          .then((querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          await querySnapshot.docs.first.reference.update({'username': newUsername});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User not found in the database.'),
            ),
          );
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username updated successfully!'),
        ),
      );
    } catch (e) {
      print('Error updating username: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update username: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          centerTitle: true,
          title: Text(
            'Change Username',
            style: GoogleFonts.lilyScriptOne(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter your new username',
                    style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF15161E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "The username can't be changed again within 14 days",
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _usernameTextController,
                    focusNode: _usernameFocusNode,
                    decoration: InputDecoration(
                      labelText: 'New Username',
                      labelStyle: GoogleFonts.lato(
                        fontSize: 14,
                        color: const Color(0xFF606A85),
                      ),
                      hintText: 'Enter your new username...',
                      hintStyle: GoogleFonts.lato(
                        fontSize: 14,
                        color: const Color(0xFF606A85),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFFE5E7EB), width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFF6F61EF), width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_usernameTextController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Username required!'),
                            ),
                          );
                        } else {
                          // Update username in Firestore
                          updateUsername(_usernameTextController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: const Color(0xFFEFCFE1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Change Username',
                        style: GoogleFonts.lilyScriptOne(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
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
}
