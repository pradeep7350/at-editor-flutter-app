import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class AIService {
  final dio = Dio();
  final baseUrl = "https://your-backend-api.com"; // Replace with real URL

  Future<File?> applyEffect(File image, String type) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "type": type,
        "image": await MultipartFile.fromFile(image.path, filename: fileName),
      });

      final response = await dio.post("\$baseUrl/apply-ai", data: formData);

      final bytes = response.data;
      final tempDir = await getTemporaryDirectory();
      final resultFile = File("\${tempDir.path}/result.jpg");
      return await resultFile.writeAsBytes(bytes);
    } catch (e) {
      print("AI API error: \$e");
      return null;
    }
  }
}
