/// Model representing a customer review for a barbershop service and capster.
class Review {
  final int? id;
  final int? idPelanggan;
  final int? idBarber;
  final int? idHistory;
  final int? idPesanan;
  final String? namaPelanggan;
  final String? namaBarber;
  final String? jenisLayanan;
  final int rating;
  final String komentar;

  Review({
    this.id,
    this.idPelanggan,
    this.idBarber,
    this.idHistory,
    this.idPesanan,
    this.namaPelanggan,
    this.namaBarber,
    this.jenisLayanan,
    required this.rating,
    required this.komentar,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      idPelanggan: json['id_pelanggan'] != null ? int.tryParse(json['id_pelanggan'].toString()) : null,
      idBarber: json['id_barber'] != null ? int.tryParse(json['id_barber'].toString()) : null,
      idHistory: json['id_history'] != null ? int.tryParse(json['id_history'].toString()) : null,
      idPesanan: json['id_pesanan'] != null ? int.tryParse(json['id_pesanan'].toString()) : null,
      namaPelanggan: json['nama_pelanggan'],
      namaBarber: json['nama_barber'],
      jenisLayanan: json['jenis_layanan'],
      rating: json['rating'] != null ? int.tryParse(json['rating'].toString()) ?? 5 : 5,
      komentar: json['komentar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'rating': rating,
      'komentar': komentar,
    };
    if (id != null) data['id'] = id;
    if (idPelanggan != null) data['id_pelanggan'] = idPelanggan;
    if (idBarber != null) data['id_barber'] = idBarber;
    if (idHistory != null) data['id_history'] = idHistory;
    if (idPesanan != null) data['id_pesanan'] = idPesanan;
    if (namaPelanggan != null) data['nama_pelanggan'] = namaPelanggan;
    if (namaBarber != null) data['nama_barber'] = namaBarber;
    if (jenisLayanan != null) data['jenis_layanan'] = jenisLayanan;
    return data;
  }
}
