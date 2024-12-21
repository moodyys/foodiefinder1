import 'package:flutter/material.dart';
import 'AdminDashBoard.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodiefinder1/Userhomepage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase only if not already initialized
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDMuwT3GL4a_JLG8ZsGtEr0taxb9E3DgUY",
        appId: "1:456235179156:web:35a46ff7be61c79795a881",
        messagingSenderId: "456235179156",
        projectId: "foodiefinder1-aee36",
        storageBucket: "foodiefinder1-aee36.firebasestorage.app",
        authDomain: "foodiefinder1-aee36.firebaseapp.com",
        measurementId: "G-83H6EK1C0C",
      ),
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Userhomepage(), // Set AdminDashBoard as the initial screen
    );
  }
}