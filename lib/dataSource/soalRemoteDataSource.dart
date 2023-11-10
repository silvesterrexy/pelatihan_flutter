// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pelatihan_flutter/models/soalResponse.dart';

class SoalRemoteDataSource {
  Future<SoalResponse> getSoal(String courseId, String email) async {
    try {
      // const url =
      //     'https://edspert.widyaedu.com/exercise/data_course?major_name=IPA&user_email=testerngbayu@gmail.com';
      final url =
          'https://edspert.widyaedu.com/exercise/data_exercise?course_id=$courseId&user_email=$email';

      final result = await Dio().get(
        url,
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );

      final courseResponse = SoalResponse.fromJson(result.data);
      // debugPrint(jsonEncode(result.data));
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
