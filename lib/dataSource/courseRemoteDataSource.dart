import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pelatihan_flutter/models/courseResponse.dart';

class CourseRemoteDataSource {
  Future<CourseResponse> getCourse(String email) async {
    try {
      final url =
          'https://edspert.widyaedu.com/exercise/data_course?major_name=IPA&user_email=$email';

      final result = await Dio().get(
        url,
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );

      final courseResponse = CourseResponse.fromJson(result.data);
      //debugPrint(jsonEncode(result.data));
      return courseResponse;
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
