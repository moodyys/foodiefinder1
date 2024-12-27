import 'package:flutter/material.dart';
import 'Settings02Widget.dart';
import 'AnalyticsWidget.dart'; // Import the AnalyticsWidget
import 'AdminProfileSettingsScreen.dart'; // Import the ProfileSettingsScreen
import 'AdminLogin.dart'; // Import the AdminLoginPage
import 'package:google_fonts/google_fonts.dart';

class AdminDashBoard extends StatelessWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.bubblegumSans(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set the color to white
          ),
        ),
        centerTitle: true,
        actions: [
          // Removed the profile button here
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE989BE), Color(0xFF6A1B9A)], // Use the same gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Profile section
            UserAccountsDrawerHeader(
              accountName: Text(
                'Admin Name',
                style: GoogleFonts.bubblegumSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ), // You can dynamically add the name here
              accountEmail: Text(
                'admin@example.com',
                style: GoogleFonts.bubblegumSans(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ), // Dynamically add email
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.account_circle, size: 50),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE989BE), Color(0xFF6A1B9A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Profile settings button
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Profile Settings',
                style: GoogleFonts.bubblegumSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // Navigate to profile settings screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminProfileSettingsScreen()),
                );
              },
            ),
            // Logout button
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: GoogleFonts.bubblegumSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // Close the drawer
                Navigator.pop(context);
                // Navigate to the AdminLoginPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminLoginPage()), // Navigate to AdminLoginPage
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3E5F5), Color(0xFFEDE7F6)], // Set the new gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDashboardButton(
                context,
                title: 'Analytics',
                icon: Icons.analytics,
                gradientColors: [Color(0xFFE989BE), Color(0xFF6A1B9A)], // Use the same gradient
                onPressed: () {
                  // Navigate to the AnalyticsWidget screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AnalyticsWidget()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildDashboardButton(
                context,
                title: 'Settings',
                icon: Icons.settings,
                gradientColors: [Color(0xFFE989BE), Color(0xFF6A1B9A)], // Use the same gradient
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings02Widget()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardButton(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<Color> gradientColors,
        required VoidCallback onPressed,
      }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 200,
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.bubblegumSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
