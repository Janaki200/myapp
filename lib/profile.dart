// Suggested code may be subject to a license. Learn more: ~LicenseLog:2655137097.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3452535555.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2386051279.
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: user123', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Email: user123@example.com', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Password: ********', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Address: 123 Main Street', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('State: California', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
