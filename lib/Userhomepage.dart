import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodiefinder1/Databases/Firestore.dart';
import 'restaurants.dart';

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

  void showCommentsPopup(BuildContext context, String reviewID, String reviewText) {
    TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Review",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                reviewText,
                style: const TextStyle(fontSize: 16),
              ),
              const Divider(),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: database.getCommentsStream(reviewID),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text('Error loading comments.'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No comments available.'));
                    }

                    final comments = snapshot.data!.docs;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        var comment = comments[index];
                        String commentText = comment['commentText'];
                        String commentedBy = comment['commentedBy'];
                        Timestamp? timestamp = comment['timestamp'];
                        DateTime commentTime = timestamp?.toDate() ?? DateTime.now();

                        return ListTile(
                          title: Text(
                            commentText,
                            style: const TextStyle(fontSize: 14),
                          ),
                          subtitle: Text(
                            "${commentedBy} • ${commentTime}",
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: "Add a comment...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () async {
                      if (commentController.text.isNotEmpty) {
                        await database.addCommentToReview(reviewID, commentController.text);
                        commentController.clear();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<Map<String, String>> fetchUserEmailsToUsernames() async {
    Map<String, String> emailToUsername = {};
    try {
      QuerySnapshot usersSnapshot =
      await FirebaseFirestore.instance.collection('users').get();

      for (var doc in usersSnapshot.docs) {
        emailToUsername[doc['useremail']] = doc['username'];
      }
    } catch (e) {
      print('Error fetching usernames: $e');
    }
    return emailToUsername;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Column(
        children: [
          Expanded(
            child: Container(
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
                        child: Stack(
                          children: [
                            Text(
                              'Fork and Feed',
                              style: GoogleFonts.boogaloo(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 4
                                  ..color = Colors.black,
                              ),
                            ),
                            Text(
                              'Fork and Feed',
                              style: GoogleFonts.boogaloo(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: database.getReviewsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return const Center(child: Text('Error loading reviews'));
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No reviews available.'));
                        }

                        final reviews = snapshot.data!.docs;

                        return FutureBuilder<Map<String, String>>(
                          future: fetchUserEmailsToUsernames(),
                          builder: (context, futureSnapshot) {
                            if (futureSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (futureSnapshot.hasError ||
                                !futureSnapshot.hasData) {
                              return const Center(
                                  child: Text('Error fetching usernames'));
                            }

                            Map<String, String> emailToUsername =
                            futureSnapshot.data!;

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: reviews.length,
                              itemBuilder: (context, index) {
                                var review = reviews[index];
                                String reviewText = review['reviewText'];
                                String userEmail = review['useremail'];
                                String username = emailToUsername[userEmail] ??
                                    'Unknown User';
                                int likesCount =
                                    (review['likes'] as List).length;
                                Timestamp timestamp = review['timestamp'];
                                String reviewID = review.id;

                                bool hasLiked = (review['likes'] as List)
                                    .contains(FirebaseAuth.instance.currentUser!
                                    .email);

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
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
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      username,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Color(0xFF222222),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      timestamp
                                                          .toDate()
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Color(0xFF888888),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            reviewText,
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
                                                  hasLiked
                                                      ? Icons.thumb_up_alt
                                                      : Icons.thumb_up_alt_outlined,
                                                  color: hasLiked
                                                      ? const Color(0xFF0072FF)
                                                      : Colors.grey,
                                                ),
                                                onPressed: () async {
                                                  if (hasLiked) {
                                                    await database.unlikeReview(
                                                        reviewID);
                                                  } else {
                                                    await database.likeReview(
                                                        reviewID);
                                                  }
                                                  setState(() {});
                                                },
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '$likesCount likes',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF444444),
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.comment,
                                                    color: Colors.grey),
                                                onPressed: () {
                                                  showCommentsPopup(context,
                                                      reviewID, reviewText);
                                                },
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
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newReviewController,
                    minLines: 1,
                    maxLines: null,
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
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: postReview,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: const Color(0xFFEFCFE1),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.send,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFEFCFE1),
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
            Navigator.pushNamed(context, '/myreviews');
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
