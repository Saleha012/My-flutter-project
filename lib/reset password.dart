import 'package:flutter/material.dart';
// Import your email service provider package

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  void _resetPassword() {
    String email = _emailController.text;

    // Generate reset token
    String resetToken = generateResetToken(); // Implement your token generation logic

    // Store reset request in DynamoDB
    storeResetRequest(email, resetToken); // Implement your DynamoDB storage logic

    // Send reset email
    sendResetEmail(email, resetToken); // Implement your email sending logic

    // Show a confirmation message to the user
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Password Reset'),
        content: Text('An email has been sent to $email with instructions to reset your password.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
              // Navigate back to the login screen or any other desired screen
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,

              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.teal), // Change the label color
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal), // Change the underline color when focused
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Change the background color
                onPrimary: Colors.white, // Change the text color
                elevation: 5, // Change the elevation
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Change the padding
                // Add more properties as needed
              ),
              child: Text('Reset Password'),
              onPressed: _resetPassword,
            )

          ],
        ),
      ),
    );
  }
}

// Function to send reset email using your email service provider
void sendResetEmail(String email, String resetToken) {
  // Implement your email sending logic here using your email service provider
}

// Function to store the reset request in DynamoDB
void storeResetRequest(String email, String resetToken) {
  // Implement your DynamoDB storage logic here
}

// Function to generate a reset token
String generateResetToken() {
  // Implement your token generation logic here

  return 'ABCD1234'; // Replace with your token generation logic
}
