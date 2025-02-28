import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:salesman/model/client_meeting_model.dart';
import 'package:salesman/model/meeting_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeetingService {
  final Dio _dio = Dio(
    BaseOptions(
      // baseUrl:
      //     'https://salesman-tracking-app.onrender.com/api', // Replace with your base URL
      headers: {"Content-Type": "application/json"},
    ),
  );

  MeetingService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          log('➡️ [MEETING REQUEST] ${options.method} ${options.path}');
          log('Headers: ${options.headers}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('✅ [MEETING RESPONSE] ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log('❌ [MEETING ERROR] ${e.response?.statusCode} ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<MeetingModel?> getMeetings() async {
    try {
      final response = await _dio
          .get('https://salesman-tracking-app.onrender.com/api/meeting');
      log('Raw API Response: ${response.data}'); // Add this line
      if (response.statusCode == 200) {
        final meetingModel = MeetingModel.fromJson(response.data);
        log('Parsed MeetingModel: ${meetingModel.meetings}'); // Add this line
        return meetingModel;
      } else {
        return null;
      }
    } on DioException catch (e) {
      log('Dio Exception: ${e.toString()}');
      return null;
    } catch (e) {
      log('General Exception: ${e.toString()}');
      return null;
    }
  }

  /// Fetch Client Meeting
  Future<ClintMeetingModel?> getClientMeeting() async {
    try {
      final response = await _dio.get('/meeting');
      log('Raw API Response: ${response.data}');
      if (response.statusCode == 200) {
        return ClintMeetingModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      log('Dio Exception: ${e.message}');
      return null;
    } catch (e) {
      log('General Exception: ${e.toString()}');
      return null;
    }
  }

  /// Create a New Client Meeting
  Future<bool> createClientMeeting({
    required String salesman,
    required String client,
    required DateTime date,
    required String location,
    required String agenda,
  }) async {
    try {
      final response = await _dio.post(
        'https://salesman-tracking-app.onrender.com/api/meeting',
        data: {
          "salesman": salesman,
          "client": client,
          "date": date.toIso8601String(),
          "location": location,
          "agenda": agenda,
        },
      );

      log('Create Meeting Response: ${response.data}');
      return response.statusCode == 201;
    } on DioException catch (e) {
      log('Dio Exception: ${e.message}');
      return false;
    } catch (e) {
      log('General Exception: ${e.toString()}');
      return false;
    }
  }
}
