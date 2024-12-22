import 'package:flutter/material.dart';
import 'Settings02Widget.dart';
import 'AnalyticsWidget.dart'; // Import the AnalyticsWidget

class AdminDashBoard extends StatelessWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
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
            colors: [Color(0xFFEDE574), Color(0xFFE1F5C4)],
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
                gradientColors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
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
                gradientColors: [Color(0xFFF2994A), Color(0xFFF2C94C)],
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
