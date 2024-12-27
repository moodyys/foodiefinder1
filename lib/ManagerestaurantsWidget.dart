import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagerestaurantsWidget extends StatefulWidget {
  const ManagerestaurantsWidget({super.key});

  @override
  State<ManagerestaurantsWidget> createState() =>
      _ManagerestaurantsWidgetState();
}

class _ManagerestaurantsWidgetState extends State<ManagerestaurantsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // List to hold restaurant names
  List<String> restaurantNames = ['Restaurant 1', 'Restaurant 2', 'Restaurant 3'];

  // Function to show dialog for adding a restaurant
  void _showAddRestaurantDialog() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add New Restaurant',
          style: GoogleFonts.bubblegumSans(), // Set the title in Bubblegum Sans
        ),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: 'Enter restaurant name',
          ),
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
              if (nameController.text.trim().isNotEmpty) {
                setState(() {
                  restaurantNames.add(nameController.text.trim());
                });
                Navigator.pop(context); // Close the dialog
              }
            },
            child: Text('Add', style: GoogleFonts.bubblegumSans()), // Use Bubblegum Sans
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Manage Restaurants',
            style: GoogleFonts.bubblegumSans(
              fontSize: 22,
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
          elevation: 4,
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline_rounded, color: Colors.white),
              onPressed: _showAddRestaurantDialog,
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF3E5F5), Color(0xFFEDE7F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: restaurantNames.length,
            itemBuilder: (context, index) {
              return _buildRestaurantCard(restaurantNames[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF6A1B9A), width: 2),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/seed/${name.hashCode}/600',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.bubblegumSans( // Set text in Bubblegum Sans
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_forever, color: Colors.red),
                onPressed: () {
                  setState(() {
                    restaurantNames.remove(name);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
