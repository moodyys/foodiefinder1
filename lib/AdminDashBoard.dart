import 'package:flutter/material.dart';
import 'Settings02Widget.dart';
import 'AnalyticsWidget.dart'; // Import the AnalyticsWidget
import 'package:google_fonts/google_fonts.dart';

class AdminDashBoard extends StatelessWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.balooTamma2(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set the color to white
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: () {
              // Add navigation or functionality for the profile icon
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Profile'),
                  content: const Text('Profile functionality coming soon!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE989BE), Color(0xFFEDFFC3)], // Use the same gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE989BE), Color(0xFFEDFFC3)], // Use the same gradient
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
                gradientColors: [Color(0xFFE989BE), Color(0xFFEDFFC3)], // Use the same gradient
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
                gradientColors: [Color(0xFFE989BE), Color(0xFFEDFFC3)], // Use the same gradient
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
              style: const TextStyle(
                fontFamily: 'Inter',
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
