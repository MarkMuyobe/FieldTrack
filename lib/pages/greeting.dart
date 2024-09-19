import 'package:flutter/material.dart';

class GreetingPage extends StatelessWidget {
  const GreetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D), // Dark background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FieldTrack Logo
            const Text(
              'FIELDTRACK',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 40, // Size for the logo text
                fontWeight: FontWeight.bold,
                color: Color(0xFF4ECB71), // Green color for the logo
                letterSpacing: 2.0, // Spacing between letters
              ),
            ),
            const SizedBox(height: 40.0), // Space between logo and welcome text

            // Welcome text
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4ECB71), // Green color for the text
              ),
            ),
            const SizedBox(height: 60.0), // Space between welcome text and buttons

            // Sign Up and Sign In Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Sign Up Button (solid background)
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup'); // Navigate to SignUpPage
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 40.0,
                    ), // Adjust button size
                    decoration: BoxDecoration(
                      color: Colors.black, // Solid black background
                      borderRadius: BorderRadius.circular(30.0), // Rounded edges
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white, // Text color for sign up
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0), // Space between buttons

                // Sign In Button (with gradient background)
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login'); // Navigate to LoginPage
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 40.0,
                    ), // Adjust button size
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF4ECB71), // #4ECB71 (light green)
                          Color(0xFF276538), // #276538 (dark green)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0), // Rounded edges
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white, // Text color for sign in
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
