import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class favorites extends StatefulWidget {
  const favorites({super.key});

  @override
  State<favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<favorites> {
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
              'Favorites',
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
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF4F9FD), Color(0xFFE1EAF5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: List.generate(5, (index) => _buildFavoriteItem()),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: Container(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Favorite Item ${DateTime.now().microsecond}',
                      style: GoogleFonts.balooTamma2(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF15161E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Description of favorite item.',
                      style: GoogleFonts.balooTamma2(
                        fontSize: 14,
                        color: const Color(0xFF606A85),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.favorite,
                  color: Color(0xFFFF6B81),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
