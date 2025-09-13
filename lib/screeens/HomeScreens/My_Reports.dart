import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserReportsScreen extends StatefulWidget {
  @override
  State<UserReportsScreen> createState() => _UserReportsScreenState();
}

class _UserReportsScreenState extends State<UserReportsScreen> {
  @override
  Widget build(BuildContext context) {
    final Color primaryLightGreen = Color(0xFF8BC34A);
    final Color primaryDarkGreen = Color(0xFF558B2F);
    final Color softGreenBackground = Color(0xFFF1F8E9);
    final Color neutralDarkGray = Color(0xFF37474F);
    final Color neutralLightGray = Color(0xFF789262);
    final Color warningRed = Color(0xFF54ff7e);

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Your Reports",style: TextStyle(fontWeight: FontWeight.bold),)),
        body: Center(child: Text("Please login to view your reports")),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFF0FDF4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
          title: Text("Your Reports",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('issue_reports')
            .where('userId', isEqualTo: currentUser.email)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error loading reports: ${snapshot.error}");
            return Center(child: Text("Error loading reports"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No reports found"));
          }

          return ListView(
            padding: EdgeInsets.all(8),
            children: snapshot.data!.docs.map((doc) {


              String getFormattedDate(Timestamp? timestamp) {
                if (timestamp == null) return 'N/A';
                DateTime dateTime = timestamp.toDate().toLocal();
                return DateFormat('dd/MM/yy').format(dateTime);
              }

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
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white, // aap project color palette me adjust kar sakte hain
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade800, // project color base
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Description:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple.shade600,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Status: ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.deepPurple.shade600,
                            ),
                          ),
                          Text(
                            status,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Reported on: ${timestamp != null ? getFormattedDate(timestamp) : 'N/A'}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Address:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple.shade600,
                        ),
                      ),
                      Text(
                        address,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Coordinates: $latitude, $longitude",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
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
