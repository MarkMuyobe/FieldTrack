import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



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
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Service Request Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _serviceName = value;
                },
              ),
              SizedBox(height: 16),

              // Description Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) {
                  _description = value;
                },
              ),
              SizedBox(height: 16),

              // Service Type Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Service type',
                  border: OutlineInputBorder(),
                ),
                value: _serviceType,
                items: ['Cleaning', 'Repair', 'Installation']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _serviceType = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),

              // Date Pickers (Day, Month, Year)
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Day',
                        border: OutlineInputBorder(),
                      ),
                      value: _day,
                      items: List.generate(31, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _day = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Month',
                        border: OutlineInputBorder(),
                      ),
                      value: _month,
                      items: List.generate(12, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _month = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Year',
                        border: OutlineInputBorder(),
                      ),
                      value: _year,
                      items: List.generate(10, (index) => 2023 + index)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _year = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Location Picker (using location_picker_flutter_map)
              TextButton.icon(
                onPressed: () {
                },
                icon: Icon(Icons.location_on),
                label: Text('Pick Location'),
              ),
              SizedBox(height: 16),

              // Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.cover)
                      : Icon(Icons.camera_alt, size: 50),
                ),
              ),
              SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    print('Form submitted');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
