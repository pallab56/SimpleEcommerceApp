import 'dart:convert';
import 'package:http/http.dart' as http;
import '../error/exceptions.dart';

class ApiClient {
  final http.Client client;
  final Future<String?> Function() getToken; // Fetches saved token from SharedPreferences/SecureStorage

  ApiClient({required this.client, required this.getToken});

  Future<Map<String, String>> _getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'token': token, // Matches your Postman collection
    };
  }

  Future<dynamic> get(String url, {Map<String, String>? queryParams}) async {
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    final response = await client.get(uri, headers: await _getHeaders());
    return _handleResponse(response);
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? body}) async {
    final response = await client.post(
      Uri.parse(url),
      headers: await _getHeaders(),
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  Future<dynamic> patch(String url, {Map<String, dynamic>? body}) async {
    final response = await client.patch(
      Uri.parse(url),
      headers: await _getHeaders(),
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String url) async {
    final response = await client.delete(
      Uri.parse(url),
      headers: await _getHeaders(),
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    final decoded = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    } else {
      // Extracts backend error message if available
      final message = decoded['msg'] ?? decoded['message'] ?? 'Something went wrong';
      throw ServerException(message: message, statusCode: response.statusCode);
    }
  }
}

