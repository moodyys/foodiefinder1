import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase{
  User? user= FirebaseAuth.instance.currentUser;

  Future<String> getUsername(String email) async {
    try {
      // Query the `users` collection for the document with the matching email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('useremail', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Return the `username` from the matching document
        return querySnapshot.docs.first['username'];
      } else {
        print("No user found with email: $email");
        return 'Anonymous';
      }
    } catch (e) {
      print("Error fetching username: $e");
      return 'Anonymous';
    }
  }

  Stream<QuerySnapshot> getCommentsStream(String reviewId) {
    return FirebaseFirestore.instance
        .collection('reviews')
        .doc(reviewId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
  final CollectionReference reviews = FirebaseFirestore.instance.collection('reviews');
  Future<void> addCommentToReview(String reviewId, String commentText) async {
    try {
      // Get the current user's email
      String? userEmail = user?.email;
      if (userEmail == null) {
        print("Error: User is not logged in.");
        return;
      }

      // Create a comment document with user details and comment text
      await reviews.doc(reviewId).collection('comments').add({
        'commentText': commentText,
        'commentedBy': userEmail, // Store the user's email who commented
        'timestamp': FieldValue.serverTimestamp(), // Store the timestamp when the comment was posted
      });

      print("Comment added successfully to review ID: $reviewId");
    } catch (e) {
      print("Error adding comment: $e");
    }
  }

  Future<void> addReview(String review) async {
    try {
      String? userEmail = user?.email;
      if (userEmail == null) {
        print("Error: User is not logged in.");
        return;
      }

      // Fetch the username for the current user
      String username = await getUsername(userEmail);

      // Add the review to Firestore
      var reviewDoc = await reviews.add({
        'useremail': userEmail,
        'username': username, // Include the retrieved username
        'reviewText': review,
        'timestamp': Timestamp.now(),
        'likes': [], // Initially, no likes
      });

      print("Review added successfully!");

      // Create a sub-collection for comments in the review document
      var commentsCollection = reviewDoc.collection('comments');


      print("Comments collection initialized successfully!");
    } catch (e) {
      print("Error adding review: $e");
    }
  }
      // After adding the review, update the document with its own reviewID

  Stream<DocumentSnapshot> getReviewDetailsStream(String reviewID) {
    return reviews.doc(reviewID).snapshots();
  }

  Stream<QuerySnapshot> getReviewsStream(){
    final reviewStream=FirebaseFirestore.instance.collection('reviews').orderBy('timestamp',descending: true).snapshots();
    return reviewStream;
  }

  Future<void> likeReview(String reviewID) async {
    try {
      // Check if the user already liked the review
      DocumentSnapshot reviewSnapshot = await reviews.doc(reviewID).get();
      List<dynamic> likes = reviewSnapshot['likes'];

      if (!likes.contains(user!.email)) {
        // If the user hasn't liked the review, add their email to the likes array
        await reviews.doc(reviewID).update({
          'likes': FieldValue.arrayUnion([user!.email]), // Add the user's email to likes
        });
        print('Review $reviewID liked by ${user!.email}');
      } else {
        print('You have already liked this review.');
      }
    } catch (e) {
      print('Error liking review: $e');
    }
  }

  Stream<QuerySnapshot> getReviewsStreamfromAccount() {
    return FirebaseFirestore.instance
        .collection('reviews')
        .where('useremail', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();
  }

  // Unlike a review: Removes the user's email from the 'likes' array of the review
  Future<void> unlikeReview(String reviewID) async {
    try {
      // Check if the user has liked the review
      DocumentSnapshot reviewSnapshot = await reviews.doc(reviewID).get();
      List<dynamic> likes = reviewSnapshot['likes'];

      if (likes.contains(user!.email)) {
        // If the user has liked the review, remove their email from the likes array
        await reviews.doc(reviewID).update({
          'likes': FieldValue.arrayRemove([user!.email]), // Remove the user's email from likes
        });
        print('Review $reviewID unliked by ${user!.email}');
      } else {
        print('You have not liked this review.');
      }
    } catch (e) {
      print('Error unliking review: $e');
    }
  }


  // Edit a review: Updates the review text in Firestore
  Future<void> editReview(String reviewID, String newText) async {
    try {
      await reviews.doc(reviewID).update({
        'reviewText': newText, // Update the review text
      });
    } catch (e) {
      print('Error editing review: $e');
    }
  }

// Delete a review: Deletes the review document from Firestore
  Future<void> deleteReview(String reviewID) async {
    try {
      await reviews.doc(reviewID).delete(); // Delete the review document
    } catch (e) {
      print('Error deleting review: $e');
    }
  }

  // Future<void> addComment(String reviewID, String commentText) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('reviews').doc(reviewID).collection('comments').add({
  //       'useremail': FirebaseAuth.instance.currentUser!.email,
  //       'commentText': commentText,
  //       'timestamp': FieldValue.serverTimestamp(),
  //       'likes': [],
  //     });
  //   } catch (e) {
  //     print('Error adding comment: $e');
  //   }
  // }
  //
  // Future<void> likeComment(String reviewID, String commentID) async {
  //   try {
  //     var commentRef = FirebaseFirestore.instance
  //         .collection('reviews')
  //         .doc(reviewID)
  //         .collection('comments')
  //         .doc(commentID);
  //
  //     var userEmail = FirebaseAuth.instance.currentUser!.email;
  //
  //     var commentSnapshot = await commentRef.get();
  //     if (commentSnapshot.exists) {
  //       var likes = List<String>.from(commentSnapshot['likes']);
  //       if (!likes.contains(userEmail)) {
  //         likes.add(userEmail!); // Add like if not already liked
  //         await commentRef.update({'likes': likes});
  //       } else {
  //         likes.remove(userEmail); // Remove like if already liked
  //         await commentRef.update({'likes': likes});
  //       }
  //     }
  //   } catch (e) {
  //     print('Error liking/unliking comment: $e');
  //   }
  // }

  // Future<void> toggleFavorite(String restaurantId, String userId) async {
  //   try {
  //     DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);
  //     DocumentSnapshot userSnapshot = await userRef.get();
  //
  //     List<dynamic> currentFavorites = userSnapshot.exists
  //         ? userSnapshot['favorites'] ?? []
  //         : [];
  //
  //     if (!currentFavorites.contains(restaurantId)) {
  //       await userRef.update({
  //         'favorites': FieldValue.arrayUnion([restaurantId]),
  //       });
  //       print('Restaurant $restaurantId added to favorites');
  //     } else {
  //       print('Restaurant $restaurantId is already in your favorites');
  //     }
  //   } catch (e) {
  //     print('Error toggling favorite: $e');
  //   }
  // }

}


