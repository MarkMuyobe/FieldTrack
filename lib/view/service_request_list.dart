import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/service_request.dart';
import 'service_request_details_page.dart';  // Add this import

class ServiceRequestList extends StatefulWidget {
  const ServiceRequestList({Key? key}) : super(key: key);

  @override
  State<ServiceRequestList> createState() => _ServiceRequestListState();
}

class _ServiceRequestListState extends State<ServiceRequestList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          _buildSearchBar(),
          _buildFilterButtons(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getFilteredStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return const Center(child: Text('No service requests found.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final serviceRequest = ServiceRequest.fromJson(docs[index].data() as Map<String, dynamic>);
                    return _buildServiceRequestCard(serviceRequest);
                  },
                );
              },
            ),
          ),
        ],
      );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(
            color: const Color(0xFF00FF7F),
            width: 2.0,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Search',
                style: TextStyle(color: Color(0xFF00FF7F)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.search, color: Color(0xFF00FF7F)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFilterButton('All'),
          _buildFilterButton('Electrical'),
          _buildFilterButton('Plumbing'),
          _buildFilterButton('IT'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: _selectedFilter == label ? const Color(0xFF00FF7F) : const Color(0xFF1E1E1E),
        side: BorderSide(
          color: const Color(0xFF00FF7F),
          width: 2.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _selectedFilter == label ? const Color(0xFF1E1E1E) : Colors.white,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget _buildServiceRequestCard(ServiceRequest serviceRequest) {
    return Card(
      color: const Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: const Color(0xFF00FF7F).withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(serviceRequest.images.isNotEmpty ? serviceRequest.images[0] : 'https://via.placeholder.com/50'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          serviceRequest.clientName,
          style: TextStyle(
            color: const Color(0xFF00FF7F).withOpacity(0.8),
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          serviceRequest.description,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        trailing: _buildStatusChip(serviceRequest.status),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceRequestDetailsPage(serviceRequest: serviceRequest),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    return Chip(
      label: Text(
        status,
        style: const TextStyle(color: Color(0xFF00FF7F), fontWeight: FontWeight.bold),
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: const Color(0xFF00FF7F).withOpacity(0.5),
          width: 1.0,
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Stream<QuerySnapshot> _getFilteredStream() {
    if (_selectedFilter == 'All') {
      return _firestore.collection('service').snapshots();
    } else {
      return _firestore.collection('service')
          .where('category', isEqualTo: _selectedFilter)  // Keep this as 'category'
          .snapshots();
    }
  }
}