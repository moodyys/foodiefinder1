import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void csvScript() async {
  await Firebase.initializeApp();

  // Path to your CSV file
  String pathToCsvFile = 'assets/restaurants.csv'; // Place your CSV file in the assets folder

  // Read CSV data
  String csvData = await rootBundle.loadString(pathToCsvFile);

  // Parse CSV
  List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

  // Iterate through rows and add them to Firestore
  for (var row in rows) {
    var restaurantName = row[0];
    var restaurantAddress = row[2];
    var restaurantDesc = row[3];

    // Add to Firestore
    await FirebaseFirestore.instance.collection('restaurants').add({
      'name': restaurantName,
      'address': restaurantAddress,
      'desc': restaurantDesc,
    });

    print('Restaurant $restaurantName added to Firestore.');
  }
}
