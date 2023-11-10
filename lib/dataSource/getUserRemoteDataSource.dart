// ignore_for_file: file_names, prefer_const_declarations

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:pelatihan_flutter/models/getUserResponse.dart';

class GetUserRemoteDataSource {
  // Future<QuestionListResponse>
  Future<GetUserResponse> getUser(
    String email,
  ) async {
    try {
      final url = 'https://edspert.widyaedu.com/users?email=$email';

      final payload = FormData.fromMap(
        {
          'email': email,
        },
      );

      final result = await Dio().get(
        url,
        data: payload,
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );

      // debugPrint(result.statusCode.toString());
      // debugPrint(jsonEncode(result.data));

      final questionListResponse = GetUserResponse.fromJson(result.data);

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
