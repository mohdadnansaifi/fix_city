import 'package:flutter/material.dart';
import '../../../data/repositories/notification_repository.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text("Notifications"),
      ),
      body: StreamBuilder(
        stream:
        NotificationRepository()
            .getNotifications(),
          builder: (context, snapshot) {
            print("State: ${snapshot.connectionState}");
            print("Has Data: ${snapshot.hasData}");
            print("Error: ${snapshot.error}");

            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                ),
              );
            }

            if (!snapshot.hasData ||
                snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No notifications yet",
                ),
              );
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index];

                return Card(
                  margin:
                  const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.notifications,
                      color: Colors.green,
                    ),
                    title: Text(
                      data['title'],
                    ),
                    subtitle: Text(
                      data['body'],
                    ),
                  ),
                );
              },
            );
          }
      ),
    );
  }
}