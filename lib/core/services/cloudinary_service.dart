import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName = "dakbio1gc";
  final String uploadPreset = "fixCity";

  Future<String> uploadImage(File file) async {
    try {
      final uri = Uri.parse(
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
      );

      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      final response = await request.send();

      final res = await http.Response.fromStream(response);
      final data = jsonDecode(res.body);

      if (response.statusCode == 200) {
        return data['secure_url']; // ✅ IMAGE URL
      } else {
        throw Exception(data['error']['message']);
      }
    } catch (e) {
      throw Exception("Cloudinary upload failed: $e");
    }
  }
}