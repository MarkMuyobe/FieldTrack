import 'package:flutter/material.dart';

class ServiceRequestList extends StatefulWidget {
  const ServiceRequestList({super.key});

  @override
  State<ServiceRequestList> createState() => _ServiceRequestListState();
}

class _ServiceRequestListState extends State<ServiceRequestList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Black background from the design
      appBar: AppBar(
        backgroundColor: const Color(0xFF00FF7F), // Green background for the title bar
        elevation: 0,
        title: const Text(
          'Service Requests',
          style: TextStyle(
            color: Color(0xFF1E1E1E), // Black text for the title
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar with green curved border and black background
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E), // Black background for search bar from design
                borderRadius: BorderRadius.circular(25.0), // Circular border
                border: Border.all(
                  color: const Color(0xFF00FF7F), // Green border color
                  width: 2.0, // Border width
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Search',
                      style: TextStyle(color: const Color(0xFF00FF7F)), // Green text for search
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.search, color: const Color(0xFF00FF7F)), // Green search icon
                  ),
                ],
              ),
            ),
          ),

          // Filter Buttons with green border, black background, and white text
          Padding(
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
          ),

          // Service Requests List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 5, // Change this to the actual number of requests
              itemBuilder: (context, index) {
                return _buildServiceRequestCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to build each filter button with green border, black background, and white text
  Widget _buildFilterButton(String label) {
    return OutlinedButton(
      onPressed: () {
        // Add filtering functionality here
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFF1E1E1E), // Black background
        side: BorderSide(
          color: const Color(0xFF00FF7F), // Green border color
          width: 2.0, // Border width
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Curved border
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white, // White text color for filter buttons
          fontSize: 14.0,
        ),
      ),
    );
  }

  // Function to build each service request card with faint green border
  Widget _buildServiceRequestCard() {
    return Card(
      color: const Color(0xFF2C2C2C), // Card background color matching the design
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: const Color(0xFF00FF7F).withOpacity(0.5), // Faint green border
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
            image: const DecorationImage(
              image: NetworkImage('https://via.placeholder.com/50'), // Placeholder for image
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          'Service Request Title',
          style: TextStyle(
            color: const Color(0xFF00FF7F).withOpacity(0.8), // Faint green for title
            fontSize: 14.0, // Smaller font for title
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: const Text(
          'Description or Type of Service',
          style: TextStyle(
            color: Colors.white, // White color for description
            fontSize: 16.0, // Larger font for description
          ),
        ),
        trailing: _buildStatusChip('Completed'),
      ),
    );
  }

  // Function to build the status chip with faint green border
  Widget _buildStatusChip(String status) {
    return Chip(
      label: Text(
        status,
        style: const TextStyle(color: Color(0xFF00FF7F), fontWeight: FontWeight.bold), // Green text for "Completed"
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: const Color(0xFF00FF7F).withOpacity(0.5), // Faint green border
          width: 1.0,
        ),
      ),
      backgroundColor: Colors.transparent, // Transparent background with green text and faint border
    );
  }
}
