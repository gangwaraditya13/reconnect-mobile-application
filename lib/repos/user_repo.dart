import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Save the JWT token locally
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  // Get stored JWT token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  // Clear token on logout
  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  // Common headers with Authorization token
  Future<Map<String, String>> _getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Register new user (sign up)
  Future<bool> registerUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
    print("signup : ${response.body}");
    print("signup : ${response.statusCode}");
    return response.statusCode == 201;
  }

  // Verify OTP after registration
  Future<bool> verifyOtp(String email, String otp) async {
    final url = Uri.parse('$baseUrl/auth/verify-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );
    print("OTP : ${response.statusCode.toString()}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['token'] != null) {
        String token = data['token'];
        await saveToken(token);
      }
      return true;
    }
    return false;
  }

  // Login User - stores token on success
  Future<bool> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    print("login : ${response.statusCode.toString()}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['token'] != null) {
        String token = data['token'];
        await saveToken(token);
      }
      return true;
    }
    return false;
  }

  // Logout
  Future<void> logoutUser() async {
    final url = Uri.parse('$baseUrl/auth/logout');
    final headers = await _getHeaders();
    await http.post(url, headers: headers);
    await clearToken();
  }

  // Get all users
  Future<List<dynamic>?> getAllUsers() async {
    final url = Uri.parse('$baseUrl/explore/users');
    final headers = await _getHeaders();
    final response = await http.get(url, headers: headers);
    print("get all user : ${response.statusCode.toString()}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['users'];
    }
    return null;
  }

  // Get all events
  Future<List<dynamic>?> getEvents() async {
    final url = Uri.parse('$baseUrl/events');
    final headers = await _getHeaders();
    final response = await http.get(url, headers: headers);
    print("get all events : ${response.statusCode.toString()}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['events'];
    }
    return null;
  }

  // Attend event
  Future<bool> attendEvent(String eventId) async {
    final url = Uri.parse('$baseUrl/events/$eventId/attend');
    final headers = await _getHeaders();
    final response = await http.post(url, headers: headers);
    print("Attend event : ${response.statusCode.toString()}");
    return response.statusCode == 200;
  }

  // Create event (admin only)
  Future<bool> createEvent(Map<String, dynamic> eventData) async {
    final url = Uri.parse('$baseUrl/admin/events');
    final headers = await _getHeaders();
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(eventData),
    );
    return response.statusCode == 201;
  }

  // Approve user (admin only)
  Future<bool> approveUser(String userId) async {
    final url = Uri.parse('$baseUrl/admin/users/$userId/approve');
    final headers = await _getHeaders();
    final response = await http.put(url, headers: headers);
    return response.statusCode == 200;
  }

  // Reject user (admin only)
  Future<bool> rejectUser(String userId) async {
    final url = Uri.parse('$baseUrl/admin/users/$userId/reject');
    final headers = await _getHeaders();
    final response = await http.put(url, headers: headers);
    return response.statusCode == 200;
  }

  // Update user profile
  Future<bool> updateUserProfile(Map<String, dynamic> updates) async {
    final url = Uri.parse('$baseUrl/profile/update');
    final headers = await _getHeaders();
    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(updates),
    );
    print("update user : ${response.statusCode.toString()}");
    return response.statusCode == 202;
  }
}
