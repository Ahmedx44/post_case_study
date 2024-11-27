import 'package:flutter/material.dart';
import 'invoice_table.dart'; // Import your InvoiceTable widget

class AdminDashboard extends StatelessWidget {
  AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isDesktop = screenWidth > 800;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dashboard Header
            const Text(
              'Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Stats Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 4 : (screenWidth > 500 ? 2 : 2),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: isDesktop ? 3 / 2 : 4 / 3,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final statData = _statData[index];

                return _buildStatCard(
                  context,
                  title: statData['title']!,
                  value: statData['value']!,
                  icon: statData['icon']!,
                );
              },
            ),

            const SizedBox(height: 20),

            // Recent Activities and Performance Chart
            isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildRecentActivities(context)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildPerformanceChart(context)),
                    ],
                  )
                : Column(
                    children: [
                      _buildRecentActivities(context),
                      const SizedBox(height: 16),
                      _buildPerformanceChart(context),
                    ],
                  ),

            const SizedBox(height: 20),

            // Invoice Table Section
            const Text(
              'Invoices',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const InvoiceTable(), // Add the InvoiceTable widget here
          ],
        ),
      ),
    );
  }

  // Helper to create a stat card
  Widget _buildStatCard(BuildContext context,
      {required String title, required String value, required IconData icon}) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isCompact = screenWidth <= 500;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding:
            isCompact ? const EdgeInsets.all(12.0) : const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon,
                size: isCompact ? 24 : 30,
                color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: isCompact ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: isCompact ? 12 : 14),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to create a recent activities section
  Widget _buildRecentActivities(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.person_add, color: Colors.blue),
              title: Text('John Doe registered'),
              subtitle: Text('5 minutes ago'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag, color: Colors.green),
              title: Text('Order #123 placed'),
              subtitle: Text('15 minutes ago'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.update, color: Colors.orange),
              title: Text('Profile updated'),
              subtitle: Text('30 minutes ago'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to create a performance chart section
  Widget _buildPerformanceChart(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Chart',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Placeholder for a chart (use a charting library like FLChart or Syncfusion)
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: const Center(
                child: Text('Chart Placeholder'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mock data for stats
  final List<Map<String, dynamic>> _statData = [
    {'title': 'Total Users', 'value': '1,245', 'icon': Icons.person_outline},
    {
      'title': 'Orders Today',
      'value': '245',
      'icon': Icons.shopping_bag_outlined
    },
    {'title': 'Revenue', 'value': '\$12,500', 'icon': Icons.attach_money},
    {
      'title': 'Pending Requests',
      'value': '15',
      'icon': Icons.pending_actions_outlined
    },
  ];
}
