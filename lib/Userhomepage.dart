import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodiefinder1/Databases/Firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'myreviews.dart';
import 'restaurants.dart';
import 'components//TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Userhomepage extends StatefulWidget {
  Userhomepage({super.key});

  @override
  _UserhomepageState createState() => _UserhomepageState();
}

class _UserhomepageState extends State<Userhomepage> {
  final TextEditingController newReviewController = TextEditingController();
  final FirestoreDatabase database = FirestoreDatabase();

  void postReview() {
    if (newReviewController.text.isNotEmpty) {
      String reviewText = newReviewController.text;
      database.addReview(reviewText);
    }
    newReviewController.clear();
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
            'Foodie Finders',
            style: GoogleFonts.pacifico(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white, // This acts as a placeholder for the gradient.
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Feed',
                    style: GoogleFonts.balooTamma2(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Row(
                  children: [
                    // Expanded widget for the text field
                    Expanded(
                      child: TextField(
                        controller: newReviewController,
                        minLines: 1, // Initial height
                        maxLines: null, // Expands as needed
                        decoration: InputDecoration(
                          hintText: "Share with your fellow foodie finders",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE989BE)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Space between the text field and button
                    // Post button with only an icon
                    ElevatedButton(
                      onPressed: () { postReview(); },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: const Color(0xFFE989BE), // Button color
                        shape: const CircleBorder(), // Circular button shape
                      ),
                      child: const Icon(
                        Icons.send, // Icon for the post button
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // StreamBuilder to display reviews and likes in real-time
              StreamBuilder<QuerySnapshot>(
                stream: database.getReviewsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error loading reviews'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No reviews available.'));
                  }

                  // If data is available, display reviews
                  final reviews = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      var review = reviews[index];
                      String reviewText = review['reviewText'];
                      String username = review['useremail'];  // Assuming useremail is used as username
                      int likesCount = (review['likes'] as List).length;
                      Timestamp timestamp = review['timestamp'];
                      String reviewID = review.id;

                      // Check if the user has liked this review
                      bool hasLiked = (review['likes'] as List).contains(FirebaseAuth.instance.currentUser!.email);

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
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            username,  // Display the username/email
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF222222),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            timestamp.toDate().toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF888888),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        // Handle options click
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  reviewText,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF444444),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        hasLiked
                                            ? Icons.thumb_up_alt // Filled blue icon if liked
                                            : Icons.thumb_up_alt_outlined, // Outline if not liked
                                        color: hasLiked ? Color(0xFF0072FF) : Colors.grey,
                                      ),
                                      onPressed: () async {
                                        if (hasLiked) {
                                          // If already liked, unlike it
                                          await database.unlikeReview(reviewID);
                                        } else {
                                          // If not liked, like it
                                          await database.likeReview(reviewID);
                                        }
                                        setState(() {}); // Refresh UI to reflect the changes
                                      },
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '$likesCount likes',
                                      style: TextStyle(
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0072FF),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'My Reviews',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/userHomePage');
          } else if (index == 1) {
            Navigator.pushNamed(context,'/myreviews');
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const restaurants()),
            );
          }
        },
      ),
    );
  }
}
