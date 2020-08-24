import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String contact;
  final String gender;
  final String password;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.contact,
    this.gender,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'contact': contact,
      'gender': gender,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      contact: map['contact'],
      gender: map['gender'],
      password: map['password'],
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
