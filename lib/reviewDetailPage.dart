import 'package:cloud_firestore/cloud_firestore.dart';  // Firestore for database
import 'package:flutter/material.dart';  // Flutter UI components
import 'package:google_fonts/google_fonts.dart';  // Google Fonts package for styling
import 'package:firebase_auth/firebase_auth.dart';  // Firebase Authentication for user identity
import 'package:foodiefinder1/Databases/Firestore.dart';  // Custom Firestore database helper functions
import 'myaccount.dart';  // Account page to navigate when user profile is clicked



class ReviewDetailPage extends StatelessWidget {
  final String reviewId;

  ReviewDetailPage({required this.reviewId});

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review Details')),
      body: Column(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('reviews').doc(reviewId).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error loading review'));
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(child: Text('Review not found'));
              }

              var review = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review['reviewText']),
                  SizedBox(height: 10),
                  Text('${review['likes'].length} Likes'),
                  SizedBox(height: 20),
                  // Display comments here
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('reviews')
                          .doc(reviewId)
                          .collection('comments')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No comments yet.'));
                        }

                        var comments = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            var comment = comments[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                title: Text(comment['text']),
                                subtitle: Text(comment['useremail']),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // Comment input
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(hintText: 'Add a comment'),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () async {
                            if (commentController.text.isNotEmpty) {
                              await FirebaseFirestore.instance
                                  .collection('reviews')
                                  .doc(reviewId)
                                  .collection('comments')
                                  .add({
                                'text': commentController.text,
                                'useremail': FirebaseAuth.instance.currentUser!.email,
                                'timestamp': FieldValue.serverTimestamp(),
                              });
                              commentController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
