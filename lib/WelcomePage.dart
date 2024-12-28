import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'CreateAccountWidget.dart';
import 'login.dart'; // Import the CreateAccountWidget here

// The WelcomePage widget is a StatelessWidget that serves as the introductory screen of the application.
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FD), // Sets a light background color for the entire page.
      body: SafeArea( // Ensures content is displayed within the safe area of the screen "make sure my animation doesnt collabe any other thing""
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spreads widgets across the column with space in between.
          children: [
            Expanded(
              child: Container(
                width: double.infinity, // Makes the container take the full width of the screen.
                decoration: const BoxDecoration(
                  gradient: LinearGradient( // Applies a gradient background to the container.
                    colors: [Color(0xFFE989BE), Color(0xFFEDFFC3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Centers the widgets vertically in the column.
                  children: [
                    Text(
                      "Welcome to FoodieFinder", // Displays the main welcome message.
                      style: GoogleFonts.lilyScriptOne(
                        fontSize: 36, // Large font size for emphasis.
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color is white for better visibility.
                      ),
                      textAlign: TextAlign.center, // Centers the text horizontally.
                    ),
                    const SizedBox(height: 16), // Adds vertical spacing between widgets.
                    Lottie.asset(
                      'assets/Welcome_animation.json', // Loads an animation from a Lottie JSON file.
                      width: 150, // Sets the animation's width.
                      height: 150, // Sets the animation's height.
                      fit: BoxFit.cover, // Ensures the animation covers the assigned dimensions proportionally.
                    ),
                    const SizedBox(height: 16), // Adds vertical spacing between widgets.
                    Text(
                      "Discover your next favorite restaurant\nand share your experiences.", // A subtitle describing the app's purpose.
                      style: GoogleFonts.balooTamma2(
                        fontSize: 16, // Smaller font size for the subtitle.
                        color: Colors.white, // Text color is white for readability.
                      ),
                      textAlign: TextAlign.center, // Centers the text horizontally.
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0), // Adds padding around the content inside the container.
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigates to the CreateAccountWidget when the button is pressed.
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAccountWidget(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0), // Adds vertical padding to the button.
                      backgroundColor: const Color(0xFFEFCFE1), // Sets the button's background color.
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Gives the button rounded corners.
                      ),
                    ),
                    child: Text(
                      'Get Started', // Button text to encourage the user to proceed.
                      style: GoogleFonts.lilyScriptOne(
                        fontSize: 16, // Font size for the button text.
                        fontWeight: FontWeight.bold, // Makes the button text bold.
                        color: Colors.white70, // Slightly transparent white color for the text.
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Adds spacing between the button and the text below.
                  TextButton(
                    onPressed: () {
                      // Navigates to the LoginPage when the text button is pressed.
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: Text(
                      "Already have an account? Log in", // Text encouraging users to log in if they already have an account.
                      style: GoogleFonts.balooTamma2(
                        color: const Color(0xFFE989BE), // Matches the app's theme color.
                        fontSize: 16, // Font size for the text.
                        fontWeight: FontWeight.bold, // Bold font for emphasis.
                        decoration: TextDecoration.underline, // Underlines the text for clarity.
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
