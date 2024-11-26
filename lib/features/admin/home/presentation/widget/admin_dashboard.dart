import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row for statistics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard(
                    context, Icons.person, 'Total Users', '1200', Colors.blue),
                _buildStatCard(context, Icons.monetization_on, 'Total Sales',
                    '\$15,000', Colors.green),
                _buildStatCard(context, Icons.pending, 'Pending Orders', '45',
                    Colors.orange),
                _buildStatCard(context, Icons.attach_money, 'Total Revenue',
                    '\$50,000', Colors.red),
              ],
            ),
            const SizedBox(height: 20), // Space between stats and main content
            // Add more content here if needed
            Expanded(
              child: Center(
                child:
                    Text('Main Content Here'), // Placeholder for main content
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, IconData icon, String title,
      String value, Color color) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.7), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0), // Padding for cards
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16, // Smaller font size
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24, // Smaller font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
