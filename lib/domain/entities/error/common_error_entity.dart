class CommonError {
  String error;
  String message;

  CommonError({required this.error, required this.message});

  factory CommonError.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return CommonError(
          error: "E0",
          message: "Something went wrong and the error response is empty.");
    }
    try {
      return CommonError(
          error: json["status"].toString(),
          message: json["errorMessage"] as String);
    } catch (e) {
      print(e.toString());
      return CommonError(
          error: "E1",
          message:
              "Server returned a malformed error, please see logcat for more details");
    }
  }
}
