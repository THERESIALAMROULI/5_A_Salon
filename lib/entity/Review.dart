import 'dart:convert';

class Review {
  final int id;
  final int idPelanggan;
  final int idBarber;
  final int idPesanan;
  final int idHistory;
  final double rating;
  final String komentar;
  final String namaPelanggan; 
  final String jenisLayanan; 

  Review({
    required this.id,
    required this.idPelanggan,
    required this.idBarber,
    required this.idPesanan,
    required this.idHistory,
    required this.rating,
    required this.komentar,
    required this.namaPelanggan,
    required this.jenisLayanan,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json['id'],
        idPelanggan: json['id_pelanggan'],
        idBarber: json['id_barber'],
        idPesanan: json['id_pesanan'],
        idHistory: json['id_history'],
        rating: (json['rating'] as num).toDouble(),
        komentar: json['komentar'],
        namaPelanggan: json['pelanggan']?['nama_pelanggan'], 
        jenisLayanan: json['layanan']?['jenis_layanan'], 
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pelanggan": idPelanggan,
        "id_barber": idBarber,
        "id_pesanan": idPesanan,
        "id_history": idHistory,
        "rating": rating,
        "komentar": komentar,
        "nama_pelanggan": namaPelanggan,
        "jenis_layanan": jenisLayanan,
      };
}
