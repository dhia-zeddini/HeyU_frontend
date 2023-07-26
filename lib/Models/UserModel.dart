class UserModel {
  late String uId;
  late String firstName;
  late String lastName;
  late String userName;
  late String email;
  late String phoneNumber;
  late String password;
  late String about;
  late String avatar;
  late List<UserModel?>? contacts;
  late List<UserModel?>? blackList;
  late String createdAt;
  late String updatedAt;

  UserModel({
    required this.uId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.about,
    required this.avatar,
    this.contacts,
    this.blackList,
    required this.createdAt,
    required this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    about = json['about'];
    avatar = json['avatar'];
    if (json['contacts'] != null) {
      contacts = <UserModel>[];
      json['contacts'].forEach((v) {
        contacts!.add(UserModel.fromJson(v));
      });
    }
    if (json['blackList'] != null) {
      blackList = <UserModel>[];
      json['blackList'].forEach((v) {
        blackList!.add(UserModel.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = uId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['userName'] = userName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['about'] = about;
    data['avatar'] = avatar;
    if (contacts != null) {
      data['contacts'] = contacts!.map((v) => v!.toJson()).toList();
    }
    if (blackList != null) {
      data['blackList'] = blackList!.map((v) => v!.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    return data;
  }
}
