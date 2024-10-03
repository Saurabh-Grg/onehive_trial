import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:onehive_frontend/app_dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClientProfileCreation extends StatefulWidget {
  @override
  _ClientProfileCreationState createState() => _ClientProfileCreationState();
}

class _ClientProfileCreationState extends State<ClientProfileCreation> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>(); // Form key to validate steps

  // Controllers for input fields
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _contactPersonController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Profile Image
  XFile? _profileImage;

  // Pick profile image function
  Future<void> _pickProfileImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _profileImage = pickedImage;
        });
      } else {
        _showSnackBar('No image selected');
      }
    } catch (e) {
      _showSnackBar('Error picking image: $e');
    }
  }

  // Display a SnackBar message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Function to build the form steps
  List<Step> _buildSteps() {
    return [
      Step(
        title: Text('Company Information'),
        content: Column(
          children: [
            GestureDetector(
              onTap: _pickProfileImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(File(_profileImage!.path))
                    : AssetImage('assets/default_profile.png') as ImageProvider,
                child: _profileImage == null
                    ? Icon(Icons.camera_alt, size: 40, color: Colors.grey[700])
                    : null,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _companyNameController,
              decoration: InputDecoration(
                labelText: 'Company Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the company name';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _contactPersonController,
              decoration: InputDecoration(
                labelText: 'Contact Person',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the contact person\'s name';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
          ],
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Location & Industry'),
        content: Column(
          children: [
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the company\'s location';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _industryController,
              decoration: InputDecoration(
                labelText: 'Industry',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the industry';
                }
                return null;
              },
            ),
          ],
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text('Website & Description'),
        content: Column(
          children: [
            TextFormField(
              controller: _websiteController,
              decoration: InputDecoration(
                labelText: 'Company Website',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the website URL';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
          ],
        ),
        isActive: _currentStep >= 2,
      ),
    ];
  }

  // Function to submit the form data to the backend
  Future<void> _submitProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        final uri = Uri.parse('http://localhost:3000/api/clientProfile/client-profile'); // Update with your backend URL
        final request = http.MultipartRequest('POST', uri);

        // Add text fields to the request
        request.fields['companyName'] = _companyNameController.text;
        request.fields['contactPerson'] = _contactPersonController.text;
        request.fields['email'] = _emailController.text;
        request.fields['phoneNumber'] = _phoneNumberController.text;
        request.fields['location'] = _locationController.text;
        request.fields['industry'] = _industryController.text;
        request.fields['website'] = _websiteController.text;
        request.fields['description'] = _descriptionController.text;

        // Add profile image if selected
        if (_profileImage != null) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'profileImage',
              _profileImage!.path,
            ),
          );
        }

        // Send the request and handle the response
        final response = await request.send();

        if (response.statusCode == 201) {
          _showSnackBar('Profile saved successfully!');

          // Clear form and navigate to the dashboard
          setState(() {
            _currentStep = 0;
            _companyNameController.clear();
            _contactPersonController.clear();
            _emailController.clear();
            _phoneNumberController.clear();
            _locationController.clear();
            _industryController.clear();
            _websiteController.clear();
            _descriptionController.clear();
            _profileImage = null;
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AppDashboard()),
          );
        } else {
          _showSnackBar('Failed to save profile. Try again.');
        }
      } catch (e) {
        _showSnackBar('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Client Profile'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent, // Match the login page color
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < _buildSteps().length - 1) {
              setState(() {
                _currentStep += 1;
              });
            } else {
              _submitProfile();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },
          steps: _buildSteps(),
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return Row(
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent, // Button color
                  ),
                  onPressed: controls.onStepContinue,
                  child: Text(_currentStep < _buildSteps().length - 1 ? 'Next' : 'Submit'),
                ),
                if (_currentStep > 0)
                  TextButton(
                    onPressed: controls.onStepCancel,
                    child: Text('Back'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
