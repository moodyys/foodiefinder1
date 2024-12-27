import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ManagerestaurantsWidget extends StatefulWidget {
  const ManagerestaurantsWidget({super.key});

  @override
  State<ManagerestaurantsWidget> createState() => _ManagerestaurantsWidgetState();
}

class _ManagerestaurantsWidgetState extends State<ManagerestaurantsWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';  // Track the search query

  // Current user reference
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  // Function to delete restaurant
  Future<void> deleteRestaurant(String restaurantId) async {
    try {
      await FirebaseFirestore.instance.collection('restaurants').doc(restaurantId).delete();
      print('Restaurant $restaurantId deleted');
    } catch (e) {
      print('Error deleting restaurant: $e');
    }
  }

  // Function to update restaurant details
  Future<void> updateRestaurant(String restaurantId, String name, String address, String desc) async {
    try {
      await FirebaseFirestore.instance.collection('restaurants').doc(restaurantId).update({
        'name': name,
        'address': address,
        'desc': desc,
      });
      print('Restaurant $restaurantId updated');
    } catch (e) {
      print('Error updating restaurant: $e');
    }
  }

  // Function to show dialog for editing restaurant
  void _showEditRestaurantDialog(String restaurantId, String currentName, String currentAddress, String currentDesc) {
    final TextEditingController nameController = TextEditingController(text: currentName);
    final TextEditingController addressController = TextEditingController(text: currentAddress);
    final TextEditingController descController = TextEditingController(text: currentDesc);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Restaurant', style: GoogleFonts.bubblegumSans()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Enter restaurant name'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(hintText: 'Enter restaurant address'),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(hintText: 'Enter restaurant description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel', style: GoogleFonts.bubblegumSans()),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty && addressController.text.trim().isNotEmpty && descController.text.trim().isNotEmpty) {
                updateRestaurant(
                  restaurantId,
                  nameController.text.trim(),
                  addressController.text.trim(),
                  descController.text.trim(),
                );
                Navigator.pop(context); // Close the dialog
              }
            },
            child: Text('Update', style: GoogleFonts.bubblegumSans()),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          centerTitle: true,
          title: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'Manage Restaurants',
              style: GoogleFonts.lilyScriptOne(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE989BE), Color(0xFFEDFFC3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF4F9FD), Color(0xFFE1EAF5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        child: TextFormField(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value.toLowerCase(); // Convert to lowercase for case-insensitive search
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Search all restaurants...',
                            labelStyle: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF606A85),
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFF6F61EF), width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: const Icon(Icons.search, color: Color(0xFF606A85)),
                          ),
                        ),
                      ),
                      const Divider(thickness: 1, color: Color(0xFFE5E7EB)),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 12, 0, 0),
                        child: Text(
                          'Restaurants',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF606A85),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // StreamBuilder to fetch and filter data from Firestore
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('restaurants')
                            .where('name_lower', isGreaterThanOrEqualTo: _searchQuery)
                            .where('name_lower', isLessThan: _searchQuery + 'z')  // to match results containing the search query
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }

                          final restaurants = snapshot.data!.docs;

                          return ListView.builder(
                            padding: const EdgeInsets.all(16),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: restaurants.length,
                            itemBuilder: (context, index) {
                              final restaurant = restaurants[index];
                              final name = restaurant['name'];
                              final address = restaurant['address'];
                              final desc = restaurant['desc'];
                              final restaurantId = restaurant.id; // Get the restaurant ID

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: const Color(0x4D9489F5),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: const Color(0xFF6F61EF)),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF15161E),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            address,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF606A85),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            desc,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF6F61EF),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton<String>(
                                      icon: const Icon(Icons.more_vert),
                                      onSelected: (String value) {
                                        if (value == 'edit') {
                                          _showEditRestaurantDialog(restaurantId, name, address, desc);
                                        } else if (value == 'delete') {
                                          deleteRestaurant(restaurantId);
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          const PopupMenuItem<String>(
                                            value: 'edit',
                                            child: Text('Edit'),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'delete',
                                            child: Text('Delete'),
                                          ),
                                        ];
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
