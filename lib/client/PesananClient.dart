import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:tubesfix/entity/Pesanan.dart' as MyPesanan;

class PesananClient {
  
  static const String _baseUrl = 'http://192.168.0.6/laravel_tubes/public/api/pesanan';

  Future<bool> createPesanan({
    required String token,
    required int idPelanggan,
    required int idBarber,
    required String tanggalPesanan,
    required String namaPemesan,
    required String layananAmbil,
    required int totalHarga,
    required String kodeBooking,
  }) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id_pelanggan': idPelanggan,
        'id_barber': idBarber,
        'tanggal_pesanan': tanggalPesanan,
        'nama_pemesan': namaPemesan,
        'total_harga' : totalHarga,
        'layanan_ambil': layananAmbil,
        'kode_booking': kodeBooking,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create pesanan: ${response.body}');
    }
  }
}