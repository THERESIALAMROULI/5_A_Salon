import 'dart:async';
import 'package:flutter/material.dart';

class PaymentView extends StatefulWidget {
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late Timer _timer;
  Duration _timeRemaining = Duration(hours: 23, minutes: 59, seconds: 59);

  @override
  void initState() {
    super.initState();
    _startCountdownTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startCountdownTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining.inSeconds > 0) {
        setState(() {
          _timeRemaining = _timeRemaining - Duration(seconds: 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours Hours $minutes Minutes $seconds Seconds';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFE0AC53)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Payment',
            style: TextStyle(
              color: Color(0xFFE0AC53),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Card(
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total payment',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              'Rp. 112.000',
                              style: TextStyle(
                                color: Color(0xFFE0AC53),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pay In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              _formatTime(_timeRemaining),
                              style: TextStyle(
                                color: Color(0xFFE0AC53),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Due Jan. 01, 2024, 23:59',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/icon_bri.png',
                              width: 70, 
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Bank Rakyat Indonesia',
                              style: TextStyle(
                                color: Color(0xFFE0AC53),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Color(0xFFE0AC53)),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account number',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '128 0813 4315 5142',
                                    style: TextStyle(
                                      color: Color(0xFFE0AC53),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.copy,
                                      color: Color(0xFFE0AC53),
                                    ),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Account number copied!'),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: Color(0xFFE0AC53)),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                'The verification process takes less than 10 minutes after successful payment',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Pay the order to the Virtual Account above before making another order with the virtual account so that the number remains the same.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '*Only accepts Bank Rakyat Indonesia',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // dropdownnya intruksinya belum bang :>
                        const SizedBox(height: 16),
                        _buildInstructionButton(
                          context,
                          'mBanking Transfer Instructions',
                        ),
                        const SizedBox(height: 8),
                        _buildInstructionButton(
                          context,
                          'ATM Transfer Instructions',
                        ),
                        const SizedBox(height: 8),
                        _buildInstructionButton(
                          context,
                          'EDC Transfer Instructions',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE0AC53),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Confirmation Submitted'),
                      ),
                    );
                  },
                  child: const Text(
                    'Confirmation',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionButton(BuildContext context, String text) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Color(0xFFE0AC53),
        side: BorderSide(color: Color(0xFFE0AC53)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {},
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
