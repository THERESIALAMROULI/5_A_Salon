import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfViewerPage extends StatelessWidget {
  final String bookingID;
  final String name;
  final String email;
  final String phoneNumber;
  final int total;
  final String date;
  final String publicationDate;
  final List<Map<String, dynamic>> services;
  final Map? data;

  const PdfViewerPage({
    Key? key,
    required this.bookingID,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.total,
    required this.date,
    required this.publicationDate,
    required this.services,
    this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'PDF Preview',
          style: TextStyle(
              color: Color(0xFFE0AC53),
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFE0AC53)),
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
        allowSharing: true,
        allowPrinting: true,
        pdfFileName: 'e_booking.pdf',
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: PdfColor.fromHex("#E0AC53"),
                width: 20, 
              ),
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(16), 
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text(
                        'ATMA BARBER',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex("#E0AC53"),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 16),
                  pw.Center(
                    child: pw.Container(
                      width: 150,
                      height: 150,
                      child: pw.BarcodeWidget(
                        barcode: pw.Barcode.qrCode(),
                        data: bookingID,
                        drawText: false,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'IDR ${total.toStringAsFixed(0)}',
                            style: pw.TextStyle(
                              fontSize: 24,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#E0AC53"),
                            ),
                          ),
                          pw.Text(
                            'Publication date: $publicationDate',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.grey,
                            ),
                          ),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            'ID BOOKING',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#E0AC53"),
                            ),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: pw.BoxDecoration(
                              color: PdfColors.grey300,
                              borderRadius: pw.BorderRadius.circular(8),
                            ),
                            child: pw.Text(
                              bookingID,
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 16),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex("#E0AC53"),
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Selected Date $date',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.white,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'Cannot refund',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.white,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  _buildDashedDivider(color: PdfColor.fromHex("#E0AC53")),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Order Details',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex("#E0AC53"),
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  _buildDetailRow('Name', name),
                  _buildDetailRow('Email', email),
                  _buildDetailRow('Phone number', phoneNumber),
                  pw.SizedBox(height: 8),
                  _buildDashedDivider(color: PdfColor.fromHex("#E0AC53")),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Services',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex("#E0AC53"),
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  for (var service in services)
                    _buildServiceRow(service['name'], service['quantity']),
                  pw.SizedBox(height: 16),

                  pw.Text(
                    'Scan the QR on the machine provided when you arrive at the Barbershop to be served.',
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontStyle: pw.FontStyle.italic,
                      color: PdfColors.grey,
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Text(
                    'Atma Barber\nNPWP: 012.345.678.9-000.000\nJl. Malioboro No. 99, Gedung A Lt. 2\nYogyakarta, Daerah Istimewa Yogyakarta - 55271',
                    style: pw.TextStyle(fontSize: 10, color: PdfColors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildDetailRow(String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 12,
            color: PdfColors.grey,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildServiceRow(String name, int quantity) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          name,
          style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
        ),
        pw.Text(
          'x $quantity',
          style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
        ),
      ],
    );
  }
}

pw.Widget _buildDashedDivider({required PdfColor color, double dashWidth = 4, double dashGap = 2}) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: List.generate(
      50,
      (index) => pw.Container(
        width: dashWidth,
        height: 1,
        color: index % 2 == 0 ? color : PdfColor(0, 0, 0, 0),
      ),
    ),
  );
}
