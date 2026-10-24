/// Model representing an order / transaction item in the customer's history.
class Transaction {
  final int? id;
  final int? idBarber;
  final String? barberName;
  final String? kodeBooking;
  final String date;
  final String service;
  final String price;
  final bool isReviewed;
  final int? reviewRating;
  final String? reviewComment;

  Transaction({
    this.id,
    this.idBarber,
    this.barberName,
    this.kodeBooking,
    required this.date,
    required this.service,
    required this.price,
    this.isReviewed = false,
    this.reviewRating,
    this.reviewComment,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] != null 
          ? int.tryParse(json['id'].toString()) 
          : (json['id_pesanan'] != null ? int.tryParse(json['id_pesanan'].toString()) : null),
      idBarber: json['id_barber'] != null ? int.tryParse(json['id_barber'].toString()) : null,
      barberName: json['barber_name'] ?? 'Atma Barber Capster',
      kodeBooking: json['kode_booking'] ?? '',
      date: json['date'] ?? '',
      service: json['service'] ?? '',
      price: json['price'] != null 
          ? (json['price'].toString().startsWith('Rp') 
              ? json['price'].toString() 
              : 'Rp ${json['price']}') 
          : 'Rp 0',
      isReviewed: json['is_reviewed'] == 1 || json['is_reviewed'] == true,
      reviewRating: json['review_rating'] != null ? int.tryParse(json['review_rating'].toString()) : null,
      reviewComment: json['review_comment'],
    );
  }
}
