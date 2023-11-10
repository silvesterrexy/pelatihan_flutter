// ignore_for_file: file_names, prefer_const_declarations

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:pelatihan_flutter/models/submitSoalResponse.dart';
import 'package:pelatihan_flutter/models/updateResponse.dart';

class SubmitSoalRemoteDataSource {
  // Future<QuestionListResponse>
  Future<SubmitSoalResponse> submit(
    String email,
    String excerciseID,
    List<String> bankQuestionID,
    List<String> studentAnswer,
  ) async {
    try {
      final url = 'https://edspert.widyaedu.com/exercise/input_jawaban';

      var payload = {
        'user_email': email,
        'exercise_id': excerciseID,
        'bank_question_id': bankQuestionID,
        'student_answer': studentAnswer,
      };

      final result = await Dio().post(
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0',
        }),
        url,
        data: jsonEncode(payload),
      );

      // debugPrint(result.statusCode.toString());
      debugPrint(jsonEncode(result.data));

      final questionListResponse = SubmitSoalResponse.fromJson(result.data);

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
