import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class favorites extends StatefulWidget {
  const favorites({super.key});

  @override
  State<favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<favorites> {
  // Current user reference
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  // Function to fetch user favorites from Firestore
  Future<List<String>> getUserFavorites() async {
    try {
      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(user!.email);
      DocumentSnapshot userSnapshot = await userRef.get();

      List<dynamic> currentFavorites = userSnapshot.exists ? userSnapshot['favorites'] ?? [] : [];
      return List<String>.from(currentFavorites);
    } catch (e) {
      print('Error fetching favorites: $e');
      return [];
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
          title: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'Favorites',
              style: GoogleFonts.lilyScriptOne(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
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
          child: FutureBuilder<List<String>>(
            future: getUserFavorites(),  // Fetch the user's favorite restaurant IDs
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No favorites found.'));
              }

              final favoriteIds = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: favoriteIds.map((restaurantId) => _buildFavoriteItem(restaurantId)).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteItem(String restaurantId) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('restaurants').doc(restaurantId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('Restaurant not found.'));
        }

        final restaurant = snapshot.data!;
        final name = restaurant['name'];
        final address = restaurant['address'];
        final desc = restaurant['desc'];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
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
                  crossAxisAlignment: CrossAxisAlignment.start, // Aligns items to start
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0x4D9489F5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF6F61EF)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(  // Make sure the column takes up available space
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.balooTamma2(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF15161E),
                            ),
                            overflow: TextOverflow.ellipsis,  // Ensure name is truncated if too long
                          ),
                          const SizedBox(height: 4),
                          Text(
                            address,
                            style: GoogleFonts.balooTamma2(
                              fontSize: 14,
                              color: const Color(0xFF606A85),
                            ),
                            overflow: TextOverflow.ellipsis,  // Ensure address is truncated if too long
                          ),
                          const SizedBox(height: 4),
                          Text(
                            desc,
                            style: GoogleFonts.balooTamma2(
                              fontSize: 12,
                              color: const Color(0xFF6F61EF),
                            ),
                            softWrap: true,  // Ensures description wraps when text overflows
                            overflow: TextOverflow.fade,  // Fade out the description if it's too long
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.favorite,
                      color: Color(0xFFFF6B81),
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
