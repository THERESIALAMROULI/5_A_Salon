class Pesanan {
  final int id;
  final int idPelanggan;
  final int idBarber;
  final DateTime tanggalPesanan;

  Pesanan({
    required this.id,
    required this.idPelanggan,
    required this.idBarber,
    required this.tanggalPesanan,
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
      id: json['id'],
      idPelanggan: json['id_pelanggan'],
      idBarber: json['id_barber'],
      tanggalPesanan: DateTime.parse(json['tanggal_pesanan']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pelanggan': idPelanggan,
      'id_barber': idBarber,
      'tanggal_pesanan': tanggalPesanan.toIso8601String(),
    };
  }
}
