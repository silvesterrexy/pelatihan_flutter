// ignore_for_file: file_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pelatihan_flutter/models/bannerResponse.dart';

class BannerRemoteDataSource {
  Future<BannerResponse> getBanners() async {
    try {
      const url = 'https://edspert.widyaedu.com/event/list?limit=5';

      final result = await Dio().get(
        url,
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );

      final bannerResponse = BannerResponse.fromJson(result.data);

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
