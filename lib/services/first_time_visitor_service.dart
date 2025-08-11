import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeVisitorService {
  static const String _baseUrl = 'https://fluoverse.onrender.com'; // Your Flask backend URL
  static const String _visitorIdKey = 'visitor_id';
  
  static FirstTimeVisitorService? _instance;
  static FirstTimeVisitorService get instance => _instance ??= FirstTimeVisitorService._();
  
  FirstTimeVisitorService._();
  
  /// Check if user is first-time visitor when they enter the website
  Future<bool> checkFirstTimeVisitor() async {
    try {
      // Get or generate visitor ID
      final visitorId = await _getOrGenerateVisitorId();
      
      // Call Flask backend to check if first-time visitor
      final response = await http.post(
        Uri.parse('$_baseUrl/check-first-time-visitor'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'visitor_id': visitorId}),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final isFirstTime = data['is_first_time'] ?? false;
        
        print('🎯 Visitor check result: ${isFirstTime ? "First-time" : "Returning"} visitor');
        print('📊 Message: ${data['message']}');
        
        return isFirstTime;
      } else {
        print('❌ Error checking visitor: ${response.statusCode}');
        return false; // Assume returning visitor on error
      }
      
    } catch (e) {
      print('❌ Error in checkFirstTimeVisitor: $e');
      return false; // Assume returning visitor on error
    }
  }
  
  /// Get existing visitor ID or generate a new one
  Future<String> _getOrGenerateVisitorId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? visitorId = prefs.getString(_visitorIdKey);
      
      if (visitorId == null) {
        // Generate new visitor ID
        visitorId = _generateVisitorId();
        await prefs.setString(_visitorIdKey, visitorId);
        print('🆔 Generated new visitor ID: $visitorId');
      } else {
        print('🆔 Using existing visitor ID: $visitorId');
      }
      
      return visitorId;
    } catch (e) {
      print('❌ Error getting visitor ID: $e');
      return _generateVisitorId();
    }
  }
  
  /// Generate a unique visitor ID
  String _generateVisitorId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 1000000).toString().padLeft(6, '0');
    final platform = kIsWeb ? 'web' : 'mobile';
    return 'visitor_${platform}_${timestamp}_$random';
  }
  
  /// Get visitor stats (optional)
  Future<int> getVisitorStats() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/visitor-stats'),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['total_first_time_visitors'] ?? 0;
      } else {
        print('❌ Error getting stats: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      print('❌ Error getting visitor stats: $e');
      return 0;
    }
  }
  
  /// Reset visitor ID (for testing)
  Future<void> resetVisitorId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_visitorIdKey);
      print('🔄 Visitor ID reset');
    } catch (e) {
      print('❌ Error resetting visitor ID: $e');
    }
  }
}
