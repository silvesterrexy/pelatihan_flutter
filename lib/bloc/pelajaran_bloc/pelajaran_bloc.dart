import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pelatihan_flutter/dataSource/courseRemoteDataSource.dart';
import 'package:pelatihan_flutter/models/courseResponse.dart';

part 'pelajaran_event.dart';
part 'pelajaran_state.dart';

class PelajaranBloc extends Bloc<PelajaranEvent, PelajaranState> {
  final CourseRemoteDataSource courseRemoteDataSource;
  final String email;

  PelajaranBloc(this.courseRemoteDataSource, this.email)
      : super(PelajaranInitial()) {
    on<PelajaranEvent>((event, emit) async {
      if (event is GetCourseListEvent) {
        emit(PelajaranLoading());
        final result = await courseRemoteDataSource.getCourse(email);

        emit(PelajaranSuccess(pelajaranResponse: result));
      }
    });
  }
}
