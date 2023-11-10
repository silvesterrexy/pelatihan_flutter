// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pelatihan_flutter/dataSource/bannerRemoteDataSource.dart';
import 'package:pelatihan_flutter/models/bannerResponse.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRemoteDataSource bannerRemoteDataSource;

  BannerBloc(this.bannerRemoteDataSource) : super(BannerInitial()) {
    on<BannerEvent>((event, emit) async {
      if (event is GetBannerListEvent) {
        emit(BannerLoading());
        final result = await bannerRemoteDataSource.getBanners();

        emit(BannerSuccess(bannerResponse: result));
      }
    });
  }
}
