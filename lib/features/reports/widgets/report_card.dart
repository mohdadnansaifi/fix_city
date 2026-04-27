import 'package:flutter/material.dart';

import '../../../Data/models/report_model.dart';

class ReportCard extends StatelessWidget {
  final ReportModel report;

  const ReportCard({super.key, required this.report});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              report.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            /// 🔹 Top Row (Category + Status)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  report.category,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(report.status).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    report.status,
                    style: TextStyle(
                      color: _getStatusColor(report.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// 🔹 Description
            Text(
              report.description,
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 12),

            /// 🔹 Divider
            const Divider(),

            const SizedBox(height: 8),

            /// 🔹 Location
            Row(
              children: [
                const Icon(Icons.location_on, size: 18, color: Colors.red),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    report.address,
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            /// 🔹 Coordinates
            Row(
              children: [
                const Icon(Icons.map, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  "${report.latitude}, ${report.longitude}",
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),

            const SizedBox(height: 6),

            /// 🔹 Date
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  _formatDate(report.timestamp),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}