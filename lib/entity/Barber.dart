import 'dart:convert';
import 'package:tubesfix/client/LayananClient.dart';

class Barber {
  final int id;
  final String namaBarber;
  final List<int> layananIds; 

  Barber({
    required this.id,
    required this.namaBarber,
    required this.layananIds,
  });

  List<String> get tags {

    return LayananClient.layanan
        .where((layanan) => layanan.id_barber == id)
        .map((layanan) => layanan.jenis_layanan)
        .toSet() 
        .toList();
  }

  factory Barber.fromJson(Map<String, dynamic> json) {
    return Barber(
      id: json['id'],
      namaBarber: json['namaBarber'],
      layananIds: List<int>.from(json['layananIds']),
    );
  }
}

