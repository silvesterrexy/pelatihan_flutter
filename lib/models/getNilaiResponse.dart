// ignore_for_file: file_names

class GetNilaiResponse {
  int? status;
  String? message;
  GetNilaiData? data;

  GetNilaiResponse({
    this.status,
    this.message,
    this.data,
  });

  factory GetNilaiResponse.fromJson(Map<String, dynamic> json) =>
      GetNilaiResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : GetNilaiData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class GetNilaiData {
  Exercise? exercise;
  Result? result;

  GetNilaiData({
    this.exercise,
    this.result,
  });

  factory GetNilaiData.fromJson(Map<String, dynamic> json) => GetNilaiData(
        exercise: json["exercise"] == null
            ? null
            : Exercise.fromJson(json["exercise"]),
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "exercise": exercise?.toJson(),
        "result": result?.toJson(),
      };
}

class Exercise {
  String? exerciseId;
  String? exerciseCode;
  String? fileCourse;
  String? icon;
  String? exerciseTitle;
  String? exerciseDescription;
  String? exerciseInstruction;
  String? countQuestion;
  String? classFk;
  String? courseFk;
  String? courseContentFk;
  String? subCourseContentFk;
  String? creatorId;
  String? creatorName;
  String? examFrom;
  String? accessType;
  String? exerciseOrder;
  String? exerciseStatus;
  DateTime? dateCreate;
  DateTime? dateUpdate;

  Exercise({
    this.exerciseId,
    this.exerciseCode,
    this.fileCourse,
    this.icon,
    this.exerciseTitle,
    this.exerciseDescription,
    this.exerciseInstruction,
    this.countQuestion,
    this.classFk,
    this.courseFk,
    this.courseContentFk,
    this.subCourseContentFk,
    this.creatorId,
    this.creatorName,
    this.examFrom,
    this.accessType,
    this.exerciseOrder,
    this.exerciseStatus,
    this.dateCreate,
    this.dateUpdate,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        exerciseId: json["exercise_id"],
        exerciseCode: json["exercise_code"],
        fileCourse: json["file_course"],
        icon: json["icon"],
        exerciseTitle: json["exercise_title"],
        exerciseDescription: json["exercise_description"],
        exerciseInstruction: json["exercise_instruction"],
        countQuestion: json["count_question"],
        classFk: json["class_fk"],
        courseFk: json["course_fk"],
        courseContentFk: json["course_content_fk"],
        subCourseContentFk: json["sub_course_content_fk"],
        creatorId: json["creator_id"],
        creatorName: json["creator_name"],
        examFrom: json["exam_from"],
        accessType: json["access_type"],
        exerciseOrder: json["exercise_order"],
        exerciseStatus: json["exercise_status"],
        dateCreate: json["date_create"] == null
            ? null
            : DateTime.parse(json["date_create"]),
        dateUpdate: json["date_update"] == null
            ? null
            : DateTime.parse(json["date_update"]),
      );

  Map<String, dynamic> toJson() => {
        "exercise_id": exerciseId,
        "exercise_code": exerciseCode,
        "file_course": fileCourse,
        "icon": icon,
        "exercise_title": exerciseTitle,
        "exercise_description": exerciseDescription,
        "exercise_instruction": exerciseInstruction,
        "count_question": countQuestion,
        "class_fk": classFk,
        "course_fk": courseFk,
        "course_content_fk": courseContentFk,
        "sub_course_content_fk": subCourseContentFk,
        "creator_id": creatorId,
        "creator_name": creatorName,
        "exam_from": examFrom,
        "access_type": accessType,
        "exercise_order": exerciseOrder,
        "exercise_status": exerciseStatus,
        "date_create": dateCreate?.toIso8601String(),
        "date_update": dateUpdate?.toIso8601String(),
      };
}

class Result {
  String? jumlahBenar;
  String? jumlahSalah;
  String? jumlahTidak;
  String? jumlahScore;

  Result({
    this.jumlahBenar,
    this.jumlahSalah,
    this.jumlahTidak,
    this.jumlahScore,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        jumlahBenar: json["jumlah_benar"],
        jumlahSalah: json["jumlah_salah"],
        jumlahTidak: json["jumlah_tidak"],
        jumlahScore: json["jumlah_score"],
      );

  Map<String, dynamic> toJson() => {
        "jumlah_benar": jumlahBenar,
        "jumlah_salah": jumlahSalah,
        "jumlah_tidak": jumlahTidak,
        "jumlah_score": jumlahScore,
      };
}
