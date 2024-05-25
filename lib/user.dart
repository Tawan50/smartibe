import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.email,
    this.phone,
    this.username,
    this.password,
    this.gender,
  });

  String? email;
  String? phone;
  String? username;
  String? password;
  String? gender;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        phone: json["phone"],
        username: json["username"],
        password: json["password"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
        "username": username,
        "password": password,
        "gender": gender,
      };
}
