import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  dynamic id;
  String username;
  String email;
  String jwt;
  User({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.jwt,
  });

  User copyWith({
    dynamic id,
    String username,
    String email,
    String jwt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      jwt: jwt ?? this.jwt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'jwt': jwt,
    };
  }

  get isAuth => this != null;

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      jwt: map['jwt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, jwt: $jwt)';
  }
}
