import 'dart:convert';

class Layanan {
  final int id;
  final String jenis_Layanan;
  final double tarif;
  final String deskripsiLayanan;
  final int id_barber;

  Layanan({
    required this.id,
    required this.jenis_Layanan,
    required this.tarif,
    required this.deskripsiLayanan,
    required this.id_barber,
  });

  factory Layanan.fromJson(Map<String, dynamic> json) {
    return Layanan(
      id: json['id'],
      jenis_Layanan: json['jenis_layanan'],
      tarif: json['tarif'] is String
          ? double.parse(json['tarif'])
          : (json['tarif'] as num).toDouble(), 
      deskripsiLayanan: json['deskripsi_layanan'],
      id_barber: json['id_barber'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_layanan": jenis_Layanan,
        "tarif": tarif,
        "deskripsi_layanan": deskripsiLayanan,
        "id_barber": id_barber,
      };
}

