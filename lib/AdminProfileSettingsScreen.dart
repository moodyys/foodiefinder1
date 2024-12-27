import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminProfileSettingsScreen extends StatelessWidget {
  const AdminProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Settings',
          style: GoogleFonts.bubblegumSans(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set the title color to white
          ),
        ),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Change Password Button
            ListTile(
              leading: Icon(Icons.lock),
              title: Text(
                'Change Password',
                style: GoogleFonts.bubblegumSans(), // Use Bubblegum Sans for text
              ),
              onTap: () {
                // Navigate to Change Password screen or show dialog
                _showChangePasswordDialog(context);
              },
            ),
            Divider(),

            // Change Email Button
            ListTile(
              leading: Icon(Icons.email),
              title: Text(
                'Change Email',
                style: GoogleFonts.bubblegumSans(), // Use Bubblegum Sans for text
              ),
              onTap: () {
                // Navigate to Change Email screen or show dialog
                _showChangeEmailDialog(context);
              },
            ),
            Divider(),

            // Notifications Section
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text(
                'Notifications',
                style: GoogleFonts.bubblegumSans(), // Use Bubblegum Sans for text
              ),
              onTap: () {
                // Navigate to Notifications settings screen or show dialog
                _showNotificationsDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Change Password',
          style: GoogleFonts.bubblegumSans(), // Use Bubblegum Sans for text
        ),
        content: TextField(
          decoration: InputDecoration(labelText: 'Enter new password'),
          obscureText: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel', style: GoogleFonts.bubblegumSans()), // Use Bubblegum Sans
          ),
          TextButton(
            onPressed: () {
              // Handle password change logic
              Navigator.pop(context);
            },
            child: Text('Change Password', style: GoogleFonts.bubblegumSans()), // Use Bubblegum Sans
          ),
        ],
      ),
    );
  }

  void _showChangeEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Change Email',
          style: GoogleFonts.bubblegumSans(), // Use Bubblegum Sans for text
        ),
        content: TextField(
          decoration: InputDecoration(labelText: 'Enter new email'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel', style: GoogleFonts.bubblegumSans()), // Use Bubblegum Sans
          ),
          TextButton(
            onPressed: () {
              // Handle email change logic
              Navigator.pop(context);
            },
            child: Text('Change Email', style: GoogleFonts.bubblegumSans()), // Use Bubblegum Sans
          ),
        ],
      ),
    );
  }

  void _showNotificationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Notifications Settings',
          style: GoogleFonts.bubblegumSans(), // Use Bubblegum Sans for text
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: Text(
                'Enable Notifications',
                style: GoogleFonts.bubblegumSans(), // Use Bubblegum Sans for text
              ),
              value: true, // You can make this dynamic later
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text(
                'Enable Email Alerts',
                style: GoogleFonts.bubblegumSans(), // Use Bubblegum Sans for text
              ),
              value: false, // You can make this dynamic later
              onChanged: (bool? value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel', style: GoogleFonts.bubblegumSans()), // Use Bubblegum Sans
          ),
          TextButton(
            onPressed: () {
              // Handle notification settings logic
              Navigator.pop(context);
            },
            child: Text('Save Settings', style: GoogleFonts.bubblegumSans()), // Use Bubblegum Sans
          ),
        ],
      ),
    );
  }
}
