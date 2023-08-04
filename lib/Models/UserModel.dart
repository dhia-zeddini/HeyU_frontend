
List<UserModel> usersFromJson(dynamic str) =>
    List<UserModel>.from((str).map((x) => UserModel.fromJson(x)));

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
  late List<String?>? contacts;
  late List<String?>? blackList;
  late String createdAt;
  late String updatedAt;
  late bool? online;

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
    this.online = false,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'] ?? '';
    about = json['about'];
    avatar = json['avatar'];
    if (json['contacts'] != null) {
      contacts = <String>[];
      json['contacts'].forEach((v) {
        contacts!.add(v);
      });
    }
    if (json['blackList'] != null) {
      blackList = <String>[];
      json['blackList'].forEach((v) {
        blackList!.add(v);
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    online = json['online'] as bool?;
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
      data['contacts'] = contacts!.map((v) => v).toList();
    }
    if (blackList != null) {
      data['blackList'] = blackList!.map((v) => v).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    return data;
  }
}
