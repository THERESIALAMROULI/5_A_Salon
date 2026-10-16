import 'dart:convert';

class Pelanggan {
  int id;
  String nama;
  String username;
  String email;
  String telepon;
  String password;

  Pelanggan({
    required this.id,
    required this.nama,
    required this.username,
    required this.email,
    required this.telepon,
    required this.password,
  });

  factory Pelanggan.fromRawJson(String str) => Pelanggan.fromJson(json.decode(str));

  factory Pelanggan.fromJson(Map<String, dynamic> json) => Pelanggan(
        id: json["id"],
        nama: json["nama"],
        username: json["username"],
        email: json["email"],
        telepon: json["telepon"],
        password: json["password"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "username": username,
        "email": email,
        "telepon": telepon,
        "password": password,
      };
}
