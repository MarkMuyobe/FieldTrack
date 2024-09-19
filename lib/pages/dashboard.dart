import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Dark background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF4ECB71), // Green app bar color
        title: const Text(
          'Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section (Title and Switch Placeholder)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // First Row (Total Requests and Pending Requests)
            const Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'Total Requests',
                    value: '29',
                    color: Color(0xFF4ECB71),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SummaryCard(
                    title: 'Pending Requests',
                    value: '12',
                    color: Color(0xFF4ECB71),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Second Row (In Progress and Complete Requests)
            const Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'In Progress',
                    value: '2',
                    color: Color(0xFF4ECB71),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SummaryCard(
                    title: 'Complete Requests',
                    value: '15',
                    color: Color(0xFF4ECB71),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Graph Section (Placeholder for now)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4ECB71),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.show_chart, // Placeholder for graph
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const SummaryCard({Key? key, required this.title, required this.value, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C), // Dark card background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
