import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'favorites.dart';
import 'chatbot.dart';  // Import your chatbot screen here
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodiefinder1/Databases/Firestore.dart';

class restaurants extends StatefulWidget {
  const restaurants({super.key});

  @override
  State<restaurants> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<restaurants> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';  // Track the search query

  // Current user reference
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  // Function to toggle favorite
  Future<void> toggleFavorite(String restaurantId) async {
    try {
      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(user!.email);
      DocumentSnapshot userSnapshot = await userRef.get();

      List<dynamic> currentFavorites = userSnapshot.exists
          ? userSnapshot['favorites'] ?? []
          : [];

      if (!currentFavorites.contains(restaurantId)) {
        await userRef.update({
          'favorites': FieldValue.arrayUnion([restaurantId]), // Add restaurant to favorites
        });
        print('Restaurant $restaurantId added to favorites');
      } else {
        await userRef.update({
          'favorites': FieldValue.arrayRemove([restaurantId]), // Remove restaurant from favorites
        });
        print('Restaurant $restaurantId removed from favorites');
      }
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  // Stream to listen for changes in the user's favorites
  Stream<List<String>> getUserFavoritesStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return List<String>.from(snapshot['favorites'] ?? []);
      } else {
        return [];
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
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
              'Restaurants',
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
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const favorites()),
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF4F9FD), Color(0xFFE1EAF5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        child: TextFormField(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value.toLowerCase(); // Convert to lowercase for case-insensitive search
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Search all restaurants...',
                            labelStyle: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF606A85),
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFF6F61EF), width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: const Icon(Icons.search, color: Color(0xFF606A85)),
                          ),
                        ),
                      ),
                      const Divider(thickness: 1, color: Color(0xFFE5E7EB)),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 12, 0, 0),
                        child: Text(
                          'Popular Today',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF606A85),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // StreamBuilder to fetch and filter data from Firestore
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('restaurants')
                            .where('name_lower', isGreaterThanOrEqualTo: _searchQuery)
                            .where('name_lower', isLessThan: _searchQuery + 'z')  // to match results containing the search query
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }

                          final restaurants = snapshot.data!.docs;

                          return ListView.builder(
                            padding: const EdgeInsets.all(16),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: restaurants.length,
                            itemBuilder: (context, index) {
                              final restaurant = restaurants[index];
                              final name = restaurant['name'];
                              final address = restaurant['address'];
                              final desc = restaurant['desc'];
                              final restaurantId = restaurant.id; // Get the restaurant ID

                              return StreamBuilder<List<String>>(
                                stream: getUserFavoritesStream(),
                                builder: (context, favoriteSnapshot) {
                                  if (!favoriteSnapshot.hasData) {
                                    return const Center(child: CircularProgressIndicator());
                                  }

                                  bool isFavorite = favoriteSnapshot.data!.contains(restaurantId);

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: Row(
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
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF15161E),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                address,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF606A85),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                desc,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF6F61EF),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            isFavorite ? Icons.favorite : Icons.favorite_border,  // Filled or outlined heart
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            toggleFavorite(restaurantId);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => chatbot()),
                  );
                },
                backgroundColor: const Color(0xFFEFCFE1),
                child: const Icon(Icons.message, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
