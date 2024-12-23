import 'package:flutter/material.dart';

class Managemyreviews extends StatefulWidget {
  const Managemyreviews({super.key});

  @override
  State<Managemyreviews> createState() => ManageMyreviews();
}

class ManageMyreviews extends State<Managemyreviews> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF14181B)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'My Reviews',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF14181B),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Reviews',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF14181B),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Your shared food experiences',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF57636C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: List.generate(
                    3,
                        (index) => buildReviewCard(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReviewCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'username',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF14181B),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'time posted',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF57636C),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Color(0xFF57636C),
                    ),
                    onPressed: () {
                      // Add your action for the remove button here
                      print('Remove button pressed');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'post',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF14181B),
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: Color(0xFF57636C),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '42',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF14181B),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 24),
                  Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        color: Color(0xFF57636C),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '15',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF14181B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
