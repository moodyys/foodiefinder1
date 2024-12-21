import 'package:flutter/material.dart';
import 'Settings02Widget.dart'; // Import the Settings02Widget class

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F3D56),
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(fontFamily: 'Inter', fontSize: 22, color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Example icon for navigation to Settings
          GestureDetector(
            onTap: () {
              // Navigate to Settings02Widget
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings02Widget()),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  Icon(Icons.settings, color: Colors.blue, size: 32),
                  SizedBox(width: 16),
                  Text(
                    'Settings',
                    style: TextStyle(fontFamily: 'Inter', fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}