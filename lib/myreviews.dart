import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodiefinder1/Databases/Firestore.dart';
import 'favorites.dart';
import 'ManageMyReviews.dart';
import 'editprofile.dart';
import 'termsofservices.dart';

class myreviews extends StatefulWidget {
  const myreviews ({Key? key}) : super(key: key);

  @override
  _MyReviewsState createState() => _MyReviewsState();
}

class _MyReviewsState extends State<myreviews> {
  final FirestoreDatabase database = FirestoreDatabase();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to the login screen after signing out
      Navigator.pushReplacementNamed(context, '/login'); // Update the route as per your app
      print('User signed out successfully');
    } catch (e) {
      print('Error signing out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  bool hasLiked(List<dynamic> likes) {
    return likes.contains(currentUser!.email);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.email)
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
            'My Reviews',
            style: GoogleFonts.lilyScriptOne(
              fontSize: 26,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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

            final user = snapshot.data!.data()!;
            final email = user['useremail'];
            final username = user['username'];

            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFE989BE), Color(0xFFEDFFC3)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  accountName: Text(
                    username,
                    style: GoogleFonts.balooTamma2(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  accountEmail: Text(
                    email,
                    style: GoogleFonts.balooTamma2(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
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
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      signOut();

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
            );
          },
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
        child: StreamBuilder<QuerySnapshot>(
          stream: database.getReviewsStreamfromAccount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Error loading reviews'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No reviews available'));
            }

            var reviews = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                var review = reviews[index];
                bool liked = hasLiked(review['likes']);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review['useremail'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF222222),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            review['timestamp'].toDate().toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF888888),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            review['reviewText'],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF444444),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  liked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                                  color: liked ? Colors.blue : const Color(0xFF0072FF),
                                ),
                                onPressed: () {
                                  if (liked) {
                                    database.unlikeReview(review.id);
                                  } else {
                                    database.likeReview(review.id);
                                  }
                                  setState(() {});
                                },
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${review['likes'].length} likes',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF444444),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),



      ),
    );
  }

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
