import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onehive_frontend/login_form.dart';




class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  // Controllers for form fields
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String _userRole = 'Client';  // Default value for dropdown
  String? _selectedCity;        // Default value for city dropdown
  bool _termsAccepted = false;  // For Terms and Conditions

  // List of cities/provinces in Nepal
  final List<String> _cities = [
    'Kathmandu', 'Pokhara', 'Lalitpur', 'Bhaktapur', 'Biratnagar', 'Chitwan'
  ];

  // Function to validate and submit the form
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_termsAccepted) {
        // Prepare data to send
        final registrationData = {
          'full_name': _fullNameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'phone_number': _phoneNumberController.text,
          'role': _userRole,
          'city': _selectedCity,
        };

        // Send POST request
        final response = await http.post(
          Uri.parse('http://localhost:3000/api/auth/register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(registrationData),
        );

        if (response.statusCode == 201) {
          // Registration successful
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Successful')));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginForm()),
          );
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Failed: ${response.body}')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please accept the terms and conditions')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OneHive Registration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Full Name
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),

              // Email Address
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              // Password
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),

              // Confirm Password
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              // Phone Number (Optional)
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number (Optional)'),
                keyboardType: TextInputType.phone,
              ),

              // User Role (Client or Freelancer)
              DropdownButtonFormField<String>(
                value: _userRole,
                decoration: InputDecoration(labelText: 'User Role'),
                items: ['Client', 'Freelancer'].map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _userRole = newValue!;
                  });
                },
              ),

              // City/Province Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: InputDecoration(labelText: 'City/Province'),
                items: _cities.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCity = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a city or province';
                  }
                  return null;
                },
              ),

              // Terms and Conditions Checkbox
              CheckboxListTile(
                title: Text("I accept the Terms and Conditions"),
                value: _termsAccepted,
                onChanged: (newValue) {
                  setState(() {
                    _termsAccepted = newValue!;
                  });
                },
              ),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Register'),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginForm()));
                },
                child: const Text("Already have an account? Login here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
