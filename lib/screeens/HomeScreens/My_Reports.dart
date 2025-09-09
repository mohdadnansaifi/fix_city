import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Your Reports")),
        body: Center(child: Text("Please login to view your reports")),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFF0FDF4),
      appBar: AppBar(title: Text("Your Reports")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('issue_reports')
            .where('userId', isEqualTo: currentUser.uid)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error loading reports"));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No reports found"));
          }

          return ListView(
            padding: EdgeInsets.all(8),
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data()! as Map<String, dynamic>;

              final category = data['category'] ?? '';
              final description = data['description'] ?? '';
              final status = data['status'] ?? '';
              final timestamp = data['timestamp'] as Timestamp?;
              final location = data['location'] as Map<String, dynamic>?;

              final latitude = location?['latitude'] ?? 0;
              final longitude = location?['longitude'] ?? 0;
              final address = location?['address'] ?? '';

              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text(category),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description: $description"),
                      Text("Status: $status"),
                      Text("Address: $address"),
                      Text("Coordinates: $latitude, $longitude"),
                      Text("Reported on: ${timestamp != null ? timestamp.toDate().toLocal().toString() : 'N/A'}"),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
