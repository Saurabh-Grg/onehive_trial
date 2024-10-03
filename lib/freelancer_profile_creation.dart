import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:onehive_frontend/app_dashboard.dart'; // Needed to display file images

class FreelancerProfileCreation extends StatefulWidget {
  @override
  _FreelancerProfileCreationState createState() => _FreelancerProfileCreationState();
}

class _FreelancerProfileCreationState extends State<FreelancerProfileCreation> {
  int _currentStep = 0; // Track the current step in the form

  // Controllers for different sections
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();

  // Profile Image, Portfolio Images, and Certificate Images
  XFile? _profileImage;
  List<XFile> _portfolioImages = [];
  List<XFile> _certificateImages = []; // Added for certificates

  // Function to pick profile image
  Future<void> _pickProfileImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
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

  // Function to pick multiple portfolio images
  Future<void> _pickPortfolioImages() async {
    final pickedImages = await ImagePicker().pickMultiImage(); // Allow multiple images
    if (pickedImages != null && pickedImages.isNotEmpty) {
      setState(() {
        _portfolioImages.addAll(pickedImages);
      });
    } else {
      _showSnackBar('No images selected');
    }
  }

  // Function to pick multiple certificate images
  Future<void> _pickCertificateImages() async {
    final pickedImages = await ImagePicker().pickMultiImage(); // Allow multiple images
    if (pickedImages != null && pickedImages.isNotEmpty) {
      setState(() {
        _certificateImages.addAll(pickedImages);
      });
    } else {
      _showSnackBar('No images selected');
    }
  }

  // Method to show SnackBar messages
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Function to build the steps
  List<Step> _buildSteps() {
    return [
      Step(
        title: Text('Personal Information'),
        content: Column(
          children: [
            // Profile Picture with an option to change
            GestureDetector(
              onTap: _pickProfileImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: _profileImage != null
                    ? FileImage(File(_profileImage!.path))
                    : AssetImage('assets/default_profile.png') as ImageProvider, // Use a default image path
                child: _profileImage == null
                    ? Icon(Icons.camera_alt, size: 40, color: Colors.grey[700])
                    : null,
              ),
            ),
            SizedBox(height: 20),
            // Input fields for Name and Bio
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Bio'),
              maxLines: 3,
            ),
          ],
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Skills'),
        content: TextField(
          controller: _skillsController,
          decoration: InputDecoration(labelText: 'Skills (comma separated)'),
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text('Experience'),
        content: TextField(
          controller: _experienceController,
          decoration: InputDecoration(labelText: 'Work Experience'),
          maxLines: 3,
        ),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: Text('Portfolio'),
        content: Column(
          children: [
            // Button to select multiple portfolio images
            ElevatedButton.icon(
              onPressed: _pickPortfolioImages,
              icon: Icon(Icons.image),
              label: Text('Add Portfolio Images'),
            ),
            SizedBox(height: 10),
            // Display selected portfolio images
            _portfolioImages.isNotEmpty
                ? GridView.builder(
              shrinkWrap: true, // To make the grid scrollable within the step
              physics: NeverScrollableScrollPhysics(), // Disable scrolling for GridView
              itemCount: _portfolioImages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 images per row
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Image.file(
                  File(_portfolioImages[index].path),
                  fit: BoxFit.cover,
                );
              },
            )
                : Text('No portfolio images added'),
          ],
        ),
        isActive: _currentStep >= 3,
      ),
      Step(
        title: Text('Education'),
        content: TextField(
          controller: _educationController,
          decoration: InputDecoration(labelText: 'Education'),
        ),
        isActive: _currentStep >= 4,
      ),
      Step(
        title: Text('Certificates'),
        content: Column(
          children: [
            // Button to select multiple certificate images
            ElevatedButton.icon(
              onPressed: _pickCertificateImages,
              icon: Icon(Icons.image),
              label: Text('Add Certificate Images'),
            ),
            SizedBox(height: 10),
            // Display selected certificate images
            _certificateImages.isNotEmpty
                ? GridView.builder(
              shrinkWrap: true, // To make the grid scrollable within the step
              physics: NeverScrollableScrollPhysics(), // Disable scrolling for GridView
              itemCount: _certificateImages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 images per row
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Image.file(
                  File(_certificateImages[index].path),
                  fit: BoxFit.cover,
                );
              },
            )
                : Text('No certificate images added'),
          ],
        ),
        isActive: _currentStep >= 5,
      ),
    ];
  }

  // Method to handle form submission
  void _submitProfile() {
    // Display a SnackBar message indicating profile is saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile Saved!'),
        duration: Duration(seconds: 2),
      ),
    );

    // Optionally, you can reset the form or navigate to another screen
    setState(() {
      _currentStep = 0; // Reset to the first step
      _nameController.clear();
      _bioController.clear();
      _skillsController.clear();
      _experienceController.clear();
      _educationController.clear();
      _profileImage = null;
      _portfolioImages.clear();
      _certificateImages.clear(); // Clear certificate images
    });

    // Navigate to the Dashboard screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AppDashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Profile'),
        centerTitle: true,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < _buildSteps().length - 1) {
            setState(() {
              _currentStep += 1;
            });
          } else {
            _submitProfile(); // Final submit when the user completes all steps
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
                onPressed: controls.onStepContinue,
                child: _currentStep == _buildSteps().length - 1 ? Text('Submit') : Text('Next'),
              ),
              SizedBox(width: 10),
              if (_currentStep > 0)
                OutlinedButton(
                  onPressed: controls.onStepCancel,
                  child: Text('Back'),
                ),
            ],
          );
        },
      ),
    );
  }
}
