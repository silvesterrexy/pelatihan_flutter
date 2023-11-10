part of 'banner_bloc.dart';

@immutable
sealed class BannerState {}

final class BannerInitial extends BannerState {}

final class BannerLoading extends BannerState {}

final class BannerSuccess extends BannerState {
  final BannerResponse bannerResponse;

  BannerSuccess({required this.bannerResponse});
}

final class BannerFailed extends BannerState {
  final String? message;

  BannerFailed({required this.message});
}
