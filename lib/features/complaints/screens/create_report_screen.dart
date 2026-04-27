import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../providers/create_report_provider.dart';
import '../../../routes/routes.dart';

class CreateReportScreen extends StatelessWidget {
  const CreateReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CreateReportProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Report"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 IMAGE SECTION
            Text(
              "Add Photo",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),

            provider.image != null
                ? Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(provider.image!),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: provider.removeImage,
                    ),
                  ),
                ),
              ],
            )
                : Container(
              height: 150,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: const Text("No image selected"),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<CreateReportProvider>()
                          .pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<CreateReportProvider>()
                          .pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Gallery"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            /// 🔹 LOCATION SECTION
            /// 🔹 LOCATION SECTION
            Text(
              "Location",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),

            provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<CreateReportProvider>().getLocation();
                },
                icon: const Icon(Icons.my_location),
                label: const Text("Get Current Location"),
              ),
            ),

            const SizedBox(height: 10),

            /// 🗺 SHOW MAP AFTER LOCATION
            if (provider.position != null)
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          provider.position!.latitude,
                          provider.position!.longitude,
                        ),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("current"),
                          position: LatLng(
                            provider.position!.latitude,
                            provider.position!.longitude,
                          ),
                        ),
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 📍 ADDRESS TEXT
                  Text(
                    "📍 ${provider.address}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            const SizedBox(height: 30),

            /// 🔹 NEXT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (provider.image == null ||
                      provider.position == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Complete all steps")),
                    );
                    return;
                  }

                  Navigator.pushNamed(
                    context,
                    AppRoutes.submit,
                    arguments: {
                      'address':provider.address,
                      'photoPath': provider.image!.path,
                      'latitude': provider.position!.latitude,
                      'longitude': provider.position!.longitude,
                    },
                  );
                },
                child: const Text("Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}