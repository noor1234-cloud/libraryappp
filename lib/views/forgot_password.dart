import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Forgot Password Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),

            // Email Field
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'YOUR EMAIL',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                  letterSpacing: 0.5,
                ),
              ),
            ),
            SizedBox(height: 5),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'abc123@example.com',
                filled: true,
                fillColor: Color(0xFFF1F3F4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 40),

            // Reset Password Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  // Forgot Password logic here
                },
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),

            // Back to Login
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back to Login
              },
              child: Text(
                "Remembered your password? Login",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
