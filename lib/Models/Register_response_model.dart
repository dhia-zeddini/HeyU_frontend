class RegisterResponseModel {
  late bool status;
  late String success;

  RegisterResponseModel({required this.status, required this.success});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    return data;
  }
}