import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int productRating = 0;
  int serviceRating = 0;
  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,  // Set background to black
      appBar: AppBar(
        title: const Text(
          'Review Product',
          style: TextStyle(color: Colors.white),  // White text color
        ),
        centerTitle: true,
        backgroundColor: Colors.black,  // Black background for AppBar
        iconTheme: const IconThemeData(color: Colors.white),  // White icon
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Give Service Rating',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),  // White text
            ),
            const SizedBox(height: 16),
            _ratingSection(
              title: 'Service Quality',
              rating: productRating,
              onRatingUpdate: (rating) {
                setState(() {
                  productRating = rating;
                });
              },
            ),
            _ratingSection(
              title: 'Barber Service',
              rating: serviceRating,
              onRatingUpdate: (rating) {
                setState(() {
                  serviceRating = rating;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Review Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),  // White text
            ),
            const SizedBox(height: 8),
            TextField(
              controller: reviewController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),  // White text color for input
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Write your review here...',
                hintStyle: const TextStyle(color: Colors.white54),  // Light hint text color
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigasi keluar
                  },
                  child: const Text(
                    'Later',
                    style: TextStyle(color: Colors.white),  // White text color
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aksi ketika review dikirim
                    if (productRating == 0 || serviceRating == 0 || reviewController.text.isEmpty) {
                      // Jika ada rating atau deskripsi kosong, beri peringatan
                      _showDialog('All fields must be filled!');
                    } else {
                      // Tampilkan dialog konfirmasi
                      _showDialog('Review successfully submitted!');
                      // Anda bisa mengirim data ke server di sini.
                      print('Product Rating: $productRating');
                      print('Service Rating: $serviceRating');
                      print('Review: ${reviewController.text}');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0AC53),
                    shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0), 
                                ),  
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),  
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _ratingSection({required String title, required int rating, required Function(int) onRatingUpdate}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),  
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              onPressed: () {
                onRatingUpdate(index + 1); 
              },
              icon: Icon(
                index < rating
                    ? Icons.star
                    : Icons.star_border,
                color: const Color(0xFFE0AC53),  
                size: 32,
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,  
          title: const Text(
            'Notification',
            style: TextStyle(color: Colors.white), 
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),  
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),  // White text color
              ),
            ),
          ],
        );
      },
    );
  }
}
