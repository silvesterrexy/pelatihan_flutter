// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pelatihan_flutter/models/getNilaiResponse.dart';

class GetNilaiRemoteDataSource {
  Future<GetNilaiResponse> getData(String exID, String email) async {
    try {
      var url =
          "https://edspert.widyaedu.com/exercise/score_result?exercise_id=$exID&user_email=$email";

      final result = await Dio().get(
        url,
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );

      final bannerResponse = GetNilaiResponse.fromJson(result.data);
      // debugPrint(jsonEncode(result.data));
      return bannerResponse;
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
