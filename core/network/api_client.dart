// lib/core/network/api_client.dart

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}

class ApiClient {
  // Change this to your teammate's Node.js server base URL
  final String baseUrl = 'http://192.168.1.100:3000';
  final Duration timeoutDuration = const Duration(seconds: 10);

  /// Performs a secure POST request with timeout and connection error handling
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      ).timeout(timeoutDuration);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        final errorBody = jsonDecode(response.body);
        throw ApiException(errorBody['error'] ?? 'Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw ApiException('Network unreachable. Check your Wi-Fi connection.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Request timed out or failed: $e');
    }
  }
}