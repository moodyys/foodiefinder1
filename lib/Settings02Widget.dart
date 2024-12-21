import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xFFEFEFEF), // Secondary background color
      appBar: AppBar(
        backgroundColor: const Color(0x6257636C),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Settings Page',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildListItem(context, 'Manage Users', Icons.chevron_right_rounded),
                _buildListItem(context, 'Manage Restaurants', Icons.chevron_right_rounded),
                _buildListItem(context, 'Flagged Reviews', Icons.chevron_right_rounded),
                _buildListItem(context, 'Help', Icons.chevron_right_rounded),
                _buildListItem(context, 'Privacy Policy', Icons.chevron_right_rounded),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            color: const Color(0xFFF9F9F9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 15, color: Color(0x7414181B)),
                  onPressed: () {
                    print('Navigate to About Us');
                  },
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              'App Version',
              style: TextStyle(fontFamily: 'Inter', fontSize: 16),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 4.0),
            child: Text(
              'v0.0.1',
              style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                backgroundColor: const Color(0xFFF9F9F9),
                side: const BorderSide(color: Color(0xFFD1D1D1), width: 1),
              ),
              onPressed: () {
                // Log out logic here
                print('User logged out');
              },
              child: const Text(
                'Log Out',
                style: TextStyle(fontFamily: 'Inter', fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 64.0),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Inter Tight',
                  fontSize: 16,
                ),
              ),
              Icon(icon, color: Colors.grey, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
