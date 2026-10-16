class Review {
  final int id;
  final int idPelanggan;
  final int idHistory;
  final int idPesanan;
  final int rating;
  final String komentar;

  Review({
    required this.id,
    required this.idPelanggan,
    required this.idHistory,
    required this.idPesanan,
    required this.rating,
    required this.komentar,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      idPelanggan: json['id_pelanggan'],
      idHistory: json['id_history'],
      idPesanan: json['id_pesanan'],
      rating: json['rating'],
      komentar: json['komentar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pelanggan': idPelanggan,
      'id_history': idHistory,
      'id_pesanan': idPesanan,
      'rating': rating,
      'komentar': komentar,
    };
  }
}
