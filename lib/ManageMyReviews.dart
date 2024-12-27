import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodiefinder1/Databases/Firestore.dart';

class Managemyreviews extends StatefulWidget {
  const Managemyreviews({super.key});

  @override
  State<Managemyreviews> createState() => ManageMyreviewsState();
}

class ManageMyreviewsState extends State<Managemyreviews> {
  final FirestoreDatabase database = FirestoreDatabase();
  User? currentUser = FirebaseAuth.instance.currentUser;

  bool hasLiked(List<dynamic> likes) {
    return likes.contains(currentUser!.email);
  }

  void _editReview(String reviewID, String currentText) async {
    TextEditingController _controller = TextEditingController(text: currentText);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Review'),
        content: TextField(
          controller: _controller,
          maxLines: 4,
          decoration: InputDecoration(hintText: 'Edit your review here'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              String updatedText = _controller.text.trim();
              if (updatedText.isNotEmpty) {
                database.editReview(reviewID, updatedText);
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _deleteReview(String reviewID) async {
    await database.deleteReview(reviewID);
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
            'Manage Reviews',
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
              colors: [Color(0xFFE989BE), Color(0xFF6A1B9A)],
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
        child: StreamBuilder<QuerySnapshot>(
          stream: database.getReviewsStreamfromAccount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error loading reviews'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No reviews available'));
            }

            var reviews = snapshot.data!.docs;
            return ListView.builder(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
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
                                  SizedBox(height: 4),
                                  Text(
                                    review['timestamp'].toDate().toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF888888),
                                    ),
                                  ),
                                ],
                              ),
                              PopupMenuButton<String>(
                                icon: Icon(Icons.more_vert, color: Color(0xFF888888)),
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _editReview(review.id, review['reviewText']);
                                  } else if (value == 'delete') {
                                    _deleteReview(review.id);
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem<String>(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ];
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            review['reviewText'],
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
                                  liked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                                  color: liked ? Colors.blue : Color(0xFF0072FF),
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
                              SizedBox(width: 4),
                              Text(
                                '${review['likes'].length} likes',
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
      ),
    );
  }
}
