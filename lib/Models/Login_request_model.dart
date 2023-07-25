class LoginRequestModel {
  late String phoneNumber;
  late String password;

  LoginRequestModel({required this.phoneNumber, required this.password});


  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    return data;
  }
}
