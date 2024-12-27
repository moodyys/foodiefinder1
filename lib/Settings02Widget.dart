import 'package:flutter/material.dart';
import 'PrivacyAndPolicyWidget.dart';
import 'UsersWidget.dart'; // Import UsersWidget
import 'FlaggedreviewsWidget.dart'; // Import FlaggedreviewsWidget
import 'ManagerestaurantsWidget.dart'; // Import ManagerestaurantsWidget
import 'HelpScreen.dart'; // Import the HelpScreen
import 'package:google_fonts/google_fonts.dart';

class Settings02Widget extends StatefulWidget {
  const Settings02Widget({Key? key}) : super(key: key);

  @override
  State<Settings02Widget> createState() => _Settings02WidgetState();
}

class _Settings02WidgetState extends State<Settings02Widget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFF3E5F5), Color(0xFFEDE7F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Settings',
            style: GoogleFonts.bubblegumSans(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Acts as a placeholder for the gradient.
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE989BE), Color(0xFF6A1B9A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3E5F5), Color(0xFFEDE7F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildListItem(context, 'Manage Users', Icons.people, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UsersWidget()),
              );
            }),
            _buildListItem(context, 'Manage Restaurants', Icons.restaurant, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManagerestaurantsWidget()),
              );
            }),
            _buildListItem(context, 'Flagged Reviews', Icons.flag, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FlaggedreviewsWidget()),
              );
            }),
            _buildListItem(context, 'Help', Icons.help, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpScreen()),
              );
            }),
            _buildListItem(context, 'Privacy Policy', Icons.privacy_tip, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyAndPolicyWidget()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title, IconData icon, VoidCallback? onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.bubblegumSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                  ),
                ),
                Icon(icon, color: const Color(0xFFE989BE), size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
