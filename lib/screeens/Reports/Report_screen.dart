import 'dart:io';
import 'package:fix_city/screeens/Reports/submit_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class createReportScreen extends StatefulWidget {
  @override
  _createReportScreenState createState() => _createReportScreenState();
}

class _createReportScreenState extends State<createReportScreen> {
  File? _imageFile;
  Position? _currentPosition;
  GoogleMapController? _mapController;
  String _address='';

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }


  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, '
            '${place.administrativeArea ?? ''}, ${place.country ?? ''}';
        return address;
      } else {
        return "No address available";
      }
    } catch (e) {
      return "Error occurred: $e";
    }
  }
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Location service check
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enable location services')),
      );
      return;
    }

    // Permission check
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return;
    }

    // Get position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
      if (_mapController != null) {
        String fetchedAddress = await getAddressFromLatLng(position.latitude, position.longitude);
        print("Address${fetchedAddress}");
        setState(() {
          _currentPosition = position;
          _address = fetchedAddress;
        });

        _mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(position.latitude, position.longitude),
    ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: $e')),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onNext() {
    if (_imageFile == null || _currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please capture/select photo and location')));
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportIssueScreen(
          photoPath: _imageFile!.path,
          latitude: _currentPosition!.latitude,
          longitude: _currentPosition!.longitude,
        ),
      ),
    );

    print('Photo path: ${_imageFile!.path}');
    print(
        'Location: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('create report',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true ,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("Add Photo",style: TextStyle(fontSize:25,fontWeight: FontWeight.bold ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("Take a photo or upload one from your gallery"),
            ),
            _imageFile != null
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  // Image
                  Image.file(
                    _imageFile!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  // Cross Icon Button (Top Right Corner)
                  Positioned(
                    right: 2,
                    top: 2,
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _imageFile=null;
                        });
                      },
                      child:CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white54.withOpacity(0.2),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    )
                  ),
                ],
              ),
            )
                : SizedBox.shrink(),


            SizedBox(height: 10,),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _pickImageFromCamera,
                    icon: Icon(Icons.camera_alt_outlined,color: Colors.black,),
                    label: Text('Take Photo',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300,40),
                      backgroundColor: Color(0xffdbeafe),
                    )
                  ),
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _pickImageFromGallery,
                    icon: Icon(Icons.file_upload_outlined,color: Colors.white,),
                    label: Text('Upload Photo',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(300,40),
                      )
                  ),
                ),
            SizedBox(height: 10),
            Divider(thickness: 1,color: Colors.grey,indent: 10,endIndent: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("Confirm your location",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("press the button and get your current location"),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _getCurrentLocation,
                icon: Icon(Icons.my_location),
                label: Text('Get Current Location'),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
              child: SizedBox(
                height: 200,
                child: _currentPosition == null
                    ? Center(child: Image(image: AssetImage('assets/map.webp')))
                    : GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentPosition!.latitude,
                        _currentPosition!.longitude),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('currentLocation'),
                      position: LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude),
                    ),
                  },
                  // mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text("Address:${_address}"),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _onNext,
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
