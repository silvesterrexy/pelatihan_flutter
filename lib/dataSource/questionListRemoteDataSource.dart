// ignore_for_file: file_names, prefer_const_declarations

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pelatihan_flutter/models/questionListResponse.dart';

class QuestionListRemoteDataSource {
  // Future<QuestionListResponse>
  Future<QuestionListResponse> getQuestionList(
      String courseId, String email) async {
    try {
      final url = 'https://edspert.widyaedu.com/exercise/kerjakan';

      final payload = FormData.fromMap(
        {
          'exercise_id': courseId,
          'user_email': email,
        },
      );

      final result = await Dio().post(
        url,
        data: payload,
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );

      // debugPrint(result.statusCode.toString());
      //debugPrint(jsonEncode(result.data));

      final questionListResponse = QuestionListResponse.fromJson(result.data);

      return questionListResponse;
    } catch (e, stacktrace) {
      log(
        e.toString(),
        stackTrace: stacktrace,
        error: e,
      );
      rethrow;
    }
  }
}
