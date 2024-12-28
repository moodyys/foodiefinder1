import 'package:flutter/material.dart';
import 'PrivacyAndPolicyWidget.dart'; // Import the Privacy and Policy screen
import 'UsersWidget.dart'; // Import the UsersWidget for managing users
import 'ManagerestaurantsWidget.dart'; // Import the Manage Restaurants screen
import 'HelpScreen.dart'; // Import the Help screen
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts for custom font styling

// Main settings screen as a StatefulWidget
class Settings02Widget extends StatefulWidget {
  const Settings02Widget({Key? key}) : super(key: key);

  @override
  State<Settings02Widget> createState() => _Settings02WidgetState();
}

class _Settings02WidgetState extends State<Settings02Widget> {
  final scaffoldKey = GlobalKey<ScaffoldState>(); // Key to manage the scaffold state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Assigning the scaffold key
      appBar: AppBar(
        elevation: 5, // Elevation for shadow effect
        centerTitle: true, // Center-align the AppBar title
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFF3E5F5), Color(0xFFEDE7F6)], // Gradient for text
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Settings', // Title of the screen
            style: GoogleFonts.bubblegumSans(
              fontSize: 30, // Font size for the title
              fontWeight: FontWeight.bold, // Bold font weight
              color: Colors.white, // Placeholder color (replaced by gradient)
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE989BE), Color(0xFF6A1B9A)], // Gradient background for AppBar
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white), // Back icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3E5F5), Color(0xFFEDE7F6)], // Background gradient for the body
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView( // List of settings options
          padding: EdgeInsets.zero, // No padding for the list view
          children: [
            _buildListItem(context, 'Manage Users', Icons.people, () { // List item for Manage Users
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UsersWidget()), // Navigate to UsersWidget
              );
            }),
            _buildListItem(context, 'Manage Restaurants', Icons.restaurant, () { // List item for Manage Restaurants
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManagerestaurantsWidget()), // Navigate to ManagerestaurantsWidget
              );
            }),
            _buildListItem(context, 'Help', Icons.help, () { // List item for Help
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpScreen()), // Navigate to HelpScreen
              );
            }),
            _buildListItem(context, 'Privacy Policy', Icons.privacy_tip, () { // List item for Privacy Policy
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyAndPolicyWidget()), // Navigate to PrivacyAndPolicyWidget
              );
            }),
          ],
        ),
      ),
    );
  }

  // Helper method to build list items for the settings options
  Widget _buildListItem(BuildContext context, String title, IconData icon, VoidCallback? onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding around each list item
      child: InkWell(
        onTap: onTap, // Action when the item is tapped
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), // Rounded corners
            color: Colors.white, // White background
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow effect
                blurRadius: 8, // Blur radius for shadow
                offset: Offset(0, 4), // Shadow offset
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Padding inside the list item
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between text and icon
              children: [
                Text(
                  title, // Title of the list item
                  style: GoogleFonts.bubblegumSans(
                    fontSize: 18, // Font size for the title
                    fontWeight: FontWeight.w600, // Semi-bold font weight
                    color: const Color(0xFF333333), // Text color
                  ),
                ),
                Icon(icon, color: const Color(0xFFE989BE), size: 24), // Icon for the list item
              ],
            ),
          ),
        ),
      ),
    );
  }
}
