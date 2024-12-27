import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void nameLower() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  // Get reference to Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Reference to the 'restaurants' collection
  CollectionReference restaurants = firestore.collection('restaurants');

  // Fetch all documents from the 'restaurants' collection
  QuerySnapshot querySnapshot = await restaurants.get();

  // Iterate through all the documents
  for (var doc in querySnapshot.docs) {
    String name = doc['name'];

    if (name != null) {
      // Convert the name to lowercase
      String nameLower = name.toLowerCase();

      // Update the document with the new 'name_lower' field
      await doc.reference.update({
        'name_lower': nameLower,
      });

      print('Updated name_lower for: $name');
    }
  }

  print('All restaurants updated with name_lower field.');
}
