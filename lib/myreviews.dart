import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'myaccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodiefinder1/Databases/Firestore.dart';

class MyReviews extends StatefulWidget {
  const MyReviews({Key? key}) : super(key: key);

  @override
  _MyReviewsState createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  final FirestoreDatabase database = FirestoreDatabase();
  User? currentUser = FirebaseAuth.instance.currentUser;

  bool hasLiked(List<dynamic> likes) {
    return likes.contains(currentUser!.email);
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
            style: GoogleFonts.pacifico(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => myaccount(),
                ),
              );
            },
          ),
        ],
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
}
