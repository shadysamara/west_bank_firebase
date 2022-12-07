import 'dart:convert';

class AppUser {
  String email;
  String? id;
  String? imageUrl;
  String userName;
  String phoneNumber;
  AppUser(
      {required this.email,
      required this.userName,
      required this.phoneNumber,
      this.id,
      this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      email: map['email'] ?? '',
      userName: map['userName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));
}
