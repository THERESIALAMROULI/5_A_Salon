import 'dart:convert';

class Layanan {
  int id;
  String jenis_layanan;
  double tarif;
  String deskripsi_layanan;
  int id_barber;

  Layanan({
    required this.id,
    required this.jenis_layanan,
    required this.tarif,
    required this.deskripsi_layanan,
    required this.id_barber,
  });

  factory Layanan.fromRawJson(String str) => Layanan.fromJson(json.decode(str));

  factory Layanan.fromJson(Map<String, dynamic> json) => Layanan(
        id: json["id"],
        jenis_layanan: json["jenis_layanan"],
        tarif: json["tarif"]?.toDouble() ?? 0.0, 
        deskripsi_layanan: json["deskripsi_layanan"],
        id_barber: json["id_barber"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_layanan": jenis_layanan,
        "tarif": tarif,
        "deskripsi_layanan": deskripsi_layanan,
        "id_barber": id_barber,
      };
}
