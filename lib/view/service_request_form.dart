import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mad_demo/model/models.dart';
import 'package:simple_location_picker/simple_location_picker_screen.dart';
import 'dart:io';
import 'package:simple_location_picker/simple_location_result.dart';
import 'package:uuid/uuid.dart';

class ServiceRequestForm extends StatefulWidget {
  const ServiceRequestForm({super.key});

  @override
  ServiceRequestFormState createState() => ServiceRequestFormState();
}

class ServiceRequestFormState extends State<ServiceRequestForm> {
  final _formKey = GlobalKey<FormState>();
  String _serviceName = '';
  String _description = '';
  String _serviceType = 'Cleaning';
  int _day = 1, _month = 1, _year = 2024;
  List<File> _images = [];
  final picker = ImagePicker();
  SimpleLocationResult? _selectedLocation;

  Future<void> _pickImages() async {
    final pickedFiles = await picker.pickMultiImage();

    setState(() {
      if (pickedFiles != null) {
        _images.addAll(pickedFiles.map((file) => File(file.path)));
      }
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Upload images to Firebase Storage
        List<String> imageUrls = await _uploadImages();

        // Create a new service request document
        await FirebaseFirestore.instance.collection('service').add({
          'clientName': _serviceName,
          'description': _description,
          'category': _serviceType,
          'dateCreated': DateTime.now().toIso8601String(),
          'scheduledDate': DateTime(_year, _month, _day).toIso8601String(),
          'status': 'Pending',
          'technicianId': '',
          'gpsLocation': '${_selectedLocation?.latitude},${_selectedLocation?.longitude}',
          'images': imageUrls,
          'notes': '',
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Service request submitted successfully')),
        );

        // Clear form
        _formKey.currentState!.reset();
        setState(() {
          _images = [];
          _selectedLocation = null;
        });
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting service request: $e')),
        );
      }
    }
  }

  Future<List<String>> _uploadImages() async {
    List<String> imageUrls = [];
    for (var image in _images) {
      String fileName = const Uuid().v4();
      Reference storageRef = FirebaseStorage.instance.ref().child('service_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Request Form', style: TextStyle(fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: inputDecoration('Name', const Icon(Icons.person_outline)),
                onChanged: (value) => _serviceName = value,
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: inputDecoration('Description', const Icon(Icons.edit)),
                maxLines: 3,
                onChanged: (value) => _description = value,
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: inputDecoration('Service type', const Icon(Icons.build)),
                value: _serviceType,
                items: ['Cleaning', 'Repair', 'Installation'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) => setState(() => _serviceType = newValue!),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: inputDecoration('Day'),
                      value: _day,
                      items: List.generate(31, (index) => index + 1).map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(value: value, child: Text(value.toString()));
                      }).toList(),
                      onChanged: (newValue) => setState(() => _day = newValue!),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: inputDecoration('Month'),
                      value: _month,
                      items: List.generate(12, (index) => index + 1).map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(value: value, child: Text(value.toString()));
                      }).toList(),
                      onChanged: (newValue) => setState(() => _month = newValue!),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: inputDecoration('Year'),
                      value: _year,
                      items: List.generate(10, (index) => 2023 + index).map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(value: value, child: Text(value.toString()));
                      }).toList(),
                      onChanged: (newValue) => setState(() => _year = newValue!),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextButton.icon(
                onPressed: () {
                  double latitude = _selectedLocation?.latitude ?? -15.42;
                  double longitude = _selectedLocation?.longitude ?? 28.29;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SimpleLocationPicker(
                      initialLatitude: latitude,
                      initialLongitude: longitude,
                      appBarTitle: 'Display Location',
                    )),
                  ).then((value) {
                    if (value != null) {
                      setState(() => _selectedLocation = value);
                    }
                  });
                },
                icon: Icon(Icons.location_on),
                label: Text('Pick Location'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImages,
                child: Text('Pick Images'),
              ),
              SizedBox(height: 8),
              _images.isNotEmpty
                  ? Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _images.map((image) => Image.file(image, width: 100, height: 100, fit: BoxFit.cover)).toList(),
                    )
                  : Container(),
              SizedBox(height: 16),
              _selectedLocation != null
                  ? Text('SELECTED: (${_selectedLocation?.latitude}, ${_selectedLocation?.longitude})')
                  : Container(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}