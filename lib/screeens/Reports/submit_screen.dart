import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:geocoding/geocoding.dart';

class ReportIssueScreen extends StatefulWidget {
  final String photoPath;
  final double latitude;
  final double longitude;

  ReportIssueScreen({
    required this.photoPath,
    required this.latitude,
    required this.longitude,
  });

  @override
  _ReportIssueScreenState createState() => _ReportIssueScreenState();
}
  @override
class _ReportIssueScreenState extends State<ReportIssueScreen> {
  final _formKey = GlobalKey<FormState>();
  String? userId;
  String? nagarNIgam;

  final List<String> categories = [
    'Pothole',
    'Water Logging',
    'Garbage',
    'Street Light',
    'Other',
  ];

  String? selectedCategory;
  TextEditingController descriptionController = TextEditingController();
  String? _address; // you need to implement how to get the address from lat/long

  @override
  @override
  void initState() {
    super.initState();
    selectedCategory = null;
    _initializeAsync();
  }

  Future<void> _initializeAsync() async {
    await fetchAndStoreUserEmail();
    _address = await getAddressFromLatLng(widget.latitude, widget.longitude);
    setState(() {});  // state update karne ke liye
  }
 //convert lat , long to city
  Future<String> getCityFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return place.locality ?? "City not found";
      }
    } catch (e) {
      print("Error in reverse geocoding: $e");
    }
    return "City not found";
  }


  //convert latitude , londtidude to address
  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
        return address;
      }
    } catch (e) {
      print("Error in reverse geocoding: $e");
    }
    return "Address not found";
  }

  Future<void> fetchAndStoreUserEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      print("User: $user");
      if (user != null && user.email != null) {
        userId = user.email;  // Email ko userId me store kar rahe hain
      } else {
        userId = null;
        print("User ya email available nahi hai");
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      userId = null;
    }
  }



  Future<void> saveIssueData({
    required String userId,
    required String category,
    required double latitude,
    required double longitude,
    required String address,
    required String description,
  }) async {
    CollectionReference issueReports = FirebaseFirestore.instance.collection('issue_reports');

    await issueReports.add({
       'userId':userId,
      'category': category,
      'description':description,
      'location': {
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      },
      'timestamp': FieldValue.serverTimestamp(),
      'status': 'reported',
    });
  }

  void submitIssue() async {
    if (userId != null && selectedCategory != null) {
      // For address, if you don't have it, you may convert lat/long to address or leave blank
      String address = _address ?? '';

      await saveIssueData(
        userId: userId!,
        category: selectedCategory!,
        latitude: widget.latitude,
        longitude: widget.longitude,
        address: address,
        description: descriptionController.text
      );
      print('Issue reported successfully');
    } else {
      print('Please provide photo and category');
    }
  }


  Future<String?> fetchNagarNigamEmail(String city) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('cities').doc(city).get();

    if (doc.exists) {
      print('Nagar Nigam Email: ${doc.get('nagarNigam')}');
      return doc.get('nagarNigam') as String?;
    }
    return null;
  }


  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> sendReportEmail() async {
      if (selectedCategory == null) {
        print('Please select a category');
        return;
      }

      String city = await getCityFromLatLng(widget.latitude, widget.longitude);
      String? nagarNigamEmail = await fetchNagarNigamEmail(city);

      if (nagarNigamEmail == null) {
        print('Nagar Nigam Email not found for city $city');
        return;
      }

      final String emailBody = """
           Issue Description:
           ${descriptionController.text}

            Location Details:
            Latitude: ${widget.latitude}
            Longitude: ${widget.longitude}
            Address: ${_address ?? 'Address not found'}
            """;

      final Email email = Email(
        body: emailBody,
        subject: selectedCategory!,
        recipients: [nagarNigamEmail],
        cc: [],
        bcc: [],
        attachmentPaths: [widget.photoPath],
        isHTML: false,
      );


      try {
        await FlutterEmailSender.send(email);
        print('Email sent to $nagarNigamEmail');
      } catch (e) {
        print('Error sending email: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Issue Details',style: TextStyle(fontWeight: FontWeight.bold,),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Problem Category:', style: TextStyle(fontSize: 16)),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  onChanged: (val) {
                    setState(() {
                      selectedCategory = val;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  items: categories
                      .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  ))
                      .toList(),
                  validator: (val) =>
                  val == null ? 'Please select a category' : null,
                ),
                SizedBox(height: 20),
                Text('Write Description:', style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Describe the issue...',
                  ),
                  validator: (val) =>
                  val == null || val.isEmpty ? 'Description required' : null,
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: ()async{
                      submitIssue();
                      await sendReportEmail();

                      setState(() {
                        descriptionController.clear();
                        selectedCategory=null;
                      }
                      );
                      Navigator.pushNamed(context,'/bottomNavigation');
                    },
                    child: Text('Submit Report'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
