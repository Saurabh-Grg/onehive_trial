import 'package:flutter/material.dart';
import 'package:onehive_frontend/app_dashboard.dart';
import 'package:onehive_frontend/client_profile_creation.dart';
import 'package:onehive_frontend/freelancer_profile_creation.dart';
// import 'package:onehive_frontend/dashboard.dart'; // Import your dashboard page

class HomePage extends StatelessWidget {
  final String full_name;
  final String email;
  final bool isFreelancer;

  HomePage({required this.full_name, required this.email, required this.isFreelancer});

  @override
  Widget build(BuildContext context) {
    print('User Email: $email');
    print('Is Freelancer: $isFreelancer');
    print('Role value: ${isFreelancer ? 'freelancer' : 'client'}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between items
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome, $full_name',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
                ),
                SizedBox(height: 40),
                // Profile creation option for freelancer
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.orangeAccent, // Button color
                  ),
                  onPressed: isFreelancer
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FreelancerProfileCreation()),
                    );
                  }
                      : null, // Disabled if not a freelancer
                  child: Text(
                    'Profile Creation as Freelancer',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                // Profile creation option for client
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.orangeAccent, // Button color
                  ),
                  onPressed: !isFreelancer
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClientProfileCreation()),
                    );
                  }
                      : null, // Disabled if a freelancer
                  child: Text(
                    'Profile Creation as Client',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
            // Skip Now Button at the bottom right
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.orangeAccent, // Button color
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppDashboard()), // Navigate to Dashboard
                  );
                },
                child: Text(
                  'Skip Now',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
