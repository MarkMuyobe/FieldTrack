import 'package:flutter/material.dart';
import '../model/service_request.dart';

class ServiceRequestDetailsPage extends StatelessWidget {
  final ServiceRequest serviceRequest;

  const ServiceRequestDetailsPage({Key? key, required this.serviceRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Client Name: ${serviceRequest.clientName}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Category: ${serviceRequest.category}'),
            SizedBox(height: 8),
            Text('Status: ${serviceRequest.status}'),
            SizedBox(height: 16),
            Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(serviceRequest.description),
            SizedBox(height: 16),
            Text('Date Created: ${serviceRequest.dateCreated.toString()}'),
            Text('Scheduled Date: ${serviceRequest.scheduledDate.toString()}'),
            if (serviceRequest.timeCompleted != null)
              Text('Time Completed: ${serviceRequest.timeCompleted.toString()}'),
            SizedBox(height: 16),
            Text('GPS Location: ${serviceRequest.gpsLocation}'),
            SizedBox(height: 16),
            Text('Notes:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(serviceRequest.notes),
            SizedBox(height: 16),
            Text('Images:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            if (serviceRequest.images.isNotEmpty)
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: serviceRequest.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.network(serviceRequest.images[index], height: 100, width: 100, fit: BoxFit.cover),
                    );
                  },
                ),
              )
            else
              Text('No images available'),
          ],
        ),
      ),
    );
  }
}