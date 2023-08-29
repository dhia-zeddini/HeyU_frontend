class RegisterRequestModel {
  late String firstName;
  late String lastName;
  late String userName;
  late String email;
  late String phoneNumber;
  late String password;
  late String about;


  RegisterRequestModel(
      {required this.firstName,
        required this.lastName,
        required this.userName,
        required this.email,
        required this.phoneNumber,
        required this.password,
        required this.about,
        });

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    about = json['about'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['userName'] = userName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['about'] = about;
    return data;
  }
}