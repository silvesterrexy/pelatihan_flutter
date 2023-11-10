part of 'pelajaran_bloc.dart';

@immutable
sealed class PelajaranState {}

final class PelajaranInitial extends PelajaranState {}

final class PelajaranLoading extends PelajaranState {}

final class PelajaranSuccess extends PelajaranState {
  final CourseResponse pelajaranResponse;

  PelajaranSuccess({required this.pelajaranResponse});
}

final class PelajaranFailed extends PelajaranState {
  final String? message;

  PelajaranFailed({required this.message});
}
