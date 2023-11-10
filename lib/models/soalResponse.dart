// ignore_for_file: file_names

class SoalResponse {
  int? status;
  String? message;
  List<SoalData>? data;

  SoalResponse({
    this.status,
    this.message,
    this.data,
  });

  factory SoalResponse.fromJson(Map<String, dynamic> json) => SoalResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SoalData>.from(
                json["data"]!.map((x) => SoalData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SoalData {
  String? exerciseId;
  String? exerciseTitle;
  String? accessType;
  String? icon;
  String? exerciseUserStatus;
  String? jumlahSoal;
  int? jumlahDone;

  SoalData({
    this.exerciseId,
    this.exerciseTitle,
    this.accessType,
    this.icon,
    this.exerciseUserStatus,
    this.jumlahSoal,
    this.jumlahDone,
  });

  factory SoalData.fromJson(Map<String, dynamic> json) => SoalData(
        exerciseId: json["exercise_id"],
        exerciseTitle: json["exercise_title"],
        accessType: json["access_type"],
        icon: json["icon"],
        exerciseUserStatus: json["exercise_user_status"],
        jumlahSoal: json["jumlah_soal"],
        jumlahDone: json["jumlah_done"],
      );

  Map<String, dynamic> toJson() => {
        "exercise_id": exerciseId,
        "exercise_title": exerciseTitle,
        "access_type": accessType,
        "icon": icon,
        "exercise_user_status": exerciseUserStatus,
        "jumlah_soal": jumlahSoal,
        "jumlah_done": jumlahDone,
      };
}
