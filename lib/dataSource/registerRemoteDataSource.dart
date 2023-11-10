// ignore_for_file: file_names, prefer_const_declarations

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:pelatihan_flutter/models/registerResponse.dart';

class RegisterRemoteDataSource {
  // Future<QuestionListResponse>
  Future<RegistrasiResponse> registrasi(
    String namaLengkap,
    String email,
    String namaSekolah,
    String kelas,
    String gender,
    String jenjang,
  ) async {
    try {
      final url = 'https://edspert.widyaedu.com/users/registrasi';

      final payload = FormData.fromMap(
        {
          'nama_lengkap': namaLengkap,
          'email': email,
          'nama_sekolah': namaSekolah,
          'kelas': kelas,
          'foto':
              'https://api.duniagames.co.id/api/content/upload/file/11297623561589089919.jpg',
          'gender': gender,
          'jenjang': jenjang,
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
      debugPrint(jsonEncode(result.data));

      final questionListResponse = RegistrasiResponse.fromJson(result.data);

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
