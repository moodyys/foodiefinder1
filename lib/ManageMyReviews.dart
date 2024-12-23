import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        appBar: AppBar(
          elevation: 5,
          centerTitle: true,
          title: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors:[Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'Manage Reviews',
              style: GoogleFonts.pacifico(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF4F9FD), Color(0xFFE1EAF5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Manage Your Reviews',
                              style: GoogleFonts.balooTamma2(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Your shared food experiences',
                              style: TextStyle(
                                fontSize: 16,
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'username',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF222222),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'time posted',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF888888),
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
                  color: Color(0xFF444444),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.favorite_border,
                        color: Color(0xFF57636C),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '42',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Row(
                    children: const [
                      Icon(
                        Icons.chat_bubble_outline,
                        color: Color(0xFF57636C),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '15',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF222222),
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
