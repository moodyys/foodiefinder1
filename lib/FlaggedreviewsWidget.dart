import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlaggedreviewsWidget extends StatefulWidget {
  const FlaggedreviewsWidget({super.key});

  @override
  State<FlaggedreviewsWidget> createState() => _FlaggedreviewsWidgetState();
}

class _FlaggedreviewsWidgetState extends State<FlaggedreviewsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xBCEC0D1A),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.grey,
            size: 25,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          '    Flagged Reviews',
          style: GoogleFonts.inter(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xBCEC0D1A),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x39000000),
                      offset: Offset(0.0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          '2,503',
                          style: GoogleFonts.inter(
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Text(
                        '# of Reviews',
                        style: GoogleFonts.inter(),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.96,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(0.0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Vacation Home',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey,
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/userAvatar.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                style: GoogleFonts.inter(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}