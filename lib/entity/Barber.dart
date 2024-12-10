import 'dart:convert';

class Barber {
  final int id;
  final String nama_barber;
  final String deskripsi;

  Barber({
    required this.id,
    required this.nama_barber,
    required this.deskripsi
  });

  factory Barber.fromJson(Map<String, dynamic> json) {
    return Barber(
      id: json['id'],
      nama_barber: json['nama_barber'], 
      deskripsi: json['deskripsi'],
    );
  }
}


