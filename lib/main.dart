import 'package:flutter/material.dart';
import 'package:onehive_frontend/client_profile_creation.dart';
import 'package:onehive_frontend/freelancer_profile_creation.dart';
import 'package:onehive_frontend/home_page.dart';
import 'package:onehive_frontend/login_form.dart';
import 'package:onehive_frontend/registration_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OneHive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginForm(), // Set LoginForm as the initial page
      routes: {
        '/home': (context) => HomePage(full_name: '', email: '', isFreelancer: false), // Placeholder, will be updated later
        '/registration': (context) => RegistrationForm(),
        '/clientProfile': (context) => ClientProfileCreation(),
        '/freelancerProfile': (context) => FreelancerProfileCreation(),
      },
    );
  }
}
