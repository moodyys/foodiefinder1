import 'package:flutter/material.dart';

class restaurants extends StatefulWidget {
  const restaurants({super.key});

  @override
  State<restaurants> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<restaurants> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

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
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite, color: Color(0xFF15161E)),
              onPressed: () {
                print('Favorite button pressed');
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Restaurants',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF15161E),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
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
                    'Popular Today',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF606A85),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
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
                                const Text(
                                  'Restaurant name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF15161E),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.chat_bubble_outline, color: Color(0xFF606A85), size: 16),
                                    const SizedBox(width: 4),
                                    const Text(
                                      '24',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF606A85),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Text(
                                      '12h',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF606A85),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'More',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6F61EF),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
