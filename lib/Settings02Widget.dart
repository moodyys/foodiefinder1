import 'package:flutter/material.dart';
import 'UsersWidget.dart'; // Import UsersWidget
import 'FlaggedreviewsWidget.dart'; // Import FlaggedreviewsWidget

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
      backgroundColor: const Color(0xFFEFEFEF),
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
                _buildListItem(context, 'Manage Users', Icons.chevron_right_rounded, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UsersWidget()),
                  );
                }),
                _buildListItem(context, 'Manage Restaurants', Icons.chevron_right_rounded, null),
                _buildListItem(context, 'Flagged Reviews', Icons.chevron_right_rounded, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FlaggedreviewsWidget()),
                  );
                }),
                _buildListItem(context, 'Help', Icons.chevron_right_rounded, null),
                _buildListItem(context, 'Privacy Policy', Icons.chevron_right_rounded, null),
              ],
            ),
          ),
          // Additional UI elements remain unchanged...
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title, IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
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
      ),
    );
  }
}
