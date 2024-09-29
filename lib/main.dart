import 'package:flutter/material.dart';
import 'package:onehive_frontend/home_page.dart';
import 'package:onehive_frontend/login_form.dart';
import 'registration_form.dart';  // Import the registration form

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OneHive Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: RegistrationForm(),

      home: LoginForm(),
      // home: HomePage(),// Use the RegistrationForm as the home page
    );
  }
}
