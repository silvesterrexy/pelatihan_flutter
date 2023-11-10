// ignore_for_file: file_names

class SubmitSoalResponse {
  int? status;
  String? message;

  SubmitSoalResponse({
    this.status,
    this.message,
  });

  factory SubmitSoalResponse.fromJson(Map<String, dynamic> json) =>
      SubmitSoalResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
