
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newproject/models/expert_model.dart';

class ExpertRepository {
  final String apiUrl = 'https://backend.goformeet.co/api/hosts';

  Future<ApiResponse> getExperts({int page = 1}) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'page': page,
        }),
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load experts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load experts: $e');
    }
  }
}