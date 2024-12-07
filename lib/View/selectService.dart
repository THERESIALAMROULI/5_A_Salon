import 'package:flutter/material.dart';
import 'package:tubesfix/View/transaction.dart';

class SelectServiceScreen extends StatefulWidget {
  final String barberName;
  final String barberImage;
  final List<String> barberTags;
  final List<String> barberReview;
  final String barberDescription;
  final Map? data;

  const SelectServiceScreen({
    Key? key,
    required this.barberName,
    required this.barberImage,
    required this.barberTags,
    required this.barberReview,
    required this.barberDescription,
    this.data
  }) : super(key: key);

  @override
  _SelectServiceScreenState createState() => _SelectServiceScreenState();
}

class SectionTitle extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Color firstTextColor;
  final Color secondTextColor;

  const SectionTitle({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.firstTextColor,
    required this.secondTextColor,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '— ',
          style: TextStyle(
            color: firstTextColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: firstText,
                style: TextStyle(
                  color: firstTextColor,
                  fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w700
                ),
              ),
              TextSpan(
                text: secondText,
                style: TextStyle(
                  color: secondTextColor,
                  fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w700
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Divider(
            color: Colors.white,
            thickness: 1.5,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  final Map<String, int> services = {
    'Haircut': 70000,
    'Treatment': 90000,
    'Mustache': 50000,
    'Coloring': 120000,
    'Beard': 40000,
    'Shaving': 30000,
  };

  final List<String> selectedServices = []; 
  TextEditingController namaController = TextEditingController();
  String? errorTextName;
  String? errorTextDate; 
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)), 
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableServices = services.keys
        .where((service) => widget.barberTags.contains(service))
        .toList();

    final selectedTotal = selectedServices
        .map((service) => services[service] ?? 0)
        .fold(0, (value, element) => value + element);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: const Text(
          'ATMA BARBER',
          style: TextStyle(
            fontFamily: 'Mixages', fontSize: 24, fontWeight: FontWeight.w700,
            color: Color(0xFFE0AC53),
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Color(0xFFE0AC53), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(widget.barberImage),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.barberName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: const [
                                    Icon(Icons.star, color: Color(0xFFE0AC53)),
                                    Icon(Icons.star, color: Color(0xFFE0AC53)),
                                    Icon(Icons.star, color: Color(0xFFE0AC53)),
                                    Icon(Icons.star, color: Color(0xFFE0AC53)),
                                    Icon(Icons.star_half, color: Color(0xFFE0AC53)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Tags:',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Wrap(
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: widget.barberTags.map((tag) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(color: const Color(0xFFE0AC53)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        tag,
                                        style: const TextStyle(
                                          color: Color(0xFFE0AC53),
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Description',
                        style: TextStyle(
                          color: Color(0xFFE0AC53),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.barberDescription,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Inter',
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Reviews',
                        style: TextStyle(
                          color: Color(0xFFE0AC53),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemCount: widget.barberReview.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.comment, size: 16, color: Color(0xFFE0AC53)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      widget.barberReview[index],
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const SectionTitle(
                firstText: 'Select ',
                secondText: 'Services',
                firstTextColor: Color(0xFFE0AC53),
                secondTextColor: Colors.white,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: availableServices.map((service) {
                  final isSelected = selectedServices.contains(service);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedServices.remove(service);
                        } else {
                          selectedServices.add(service);
                        }
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: isSelected
                              ? Color(0xFFE0AC53)
                              : Colors.white54,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        service,
                        style: TextStyle(
                          color: isSelected ? Color(0xFFE0AC53) : Colors.white54,
                          fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  hintText: 'Booking Name...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Color(0xFFE0AC53), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white54),
                  ),
                  errorText: errorTextName, 
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, 
                      children: [
                        OutlinedButton(
                          onPressed: () => _selectDate(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFE0AC53)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size.fromHeight(48), 
                          ),
                          child: Text(
                            selectedDate == null
                                ? 'Select Date'
                                : 'Date: ${selectedDate!.toLocal().toString().split(' ')[0]}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (errorTextDate != null) 
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              errorTextDate!, 
                              textAlign: TextAlign.center, 
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xFFE0AC53)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ...selectedServices.map((service) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              service,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                              'Rp. ${services[service]!.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      const Divider(color: Color(0xFFE0AC53)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w700
                            ),
                          ),
                          Text(
                            'Rp. ${selectedTotal.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE0AC53)),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Color(0xFFE0AC53), fontFamily: 'Inter', fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final today = DateTime.now();
                        if (namaController.text.isEmpty) {
                          setState(() {
                            errorTextName = 'Booking Name cannot be empty';
                          });
                        } else if (selectedDate == null) {
                          setState(() {
                            errorTextDate = 'Please select a date';
                          });
                        } else if (selectedDate!.year == today.year &&
                            selectedDate!.month == today.month &&
                            selectedDate!.day == today.day) {
                          setState(() {
                            errorTextDate = 'You cannot book for today. Select a later date.';
                          });
                        } else {
                          setState(() {
                            errorTextName = null;
                            errorTextDate = null;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => transactionView(
                                dataformat: {
                                  'nama': namaController.text,
                                  'date': selectedDate,
                                  'services': selectedServices,
                                  'servicesPdf': selectedServices
                                      .where((service) => services.containsKey(service))
                                      .map((service) => {'name': service, 'quantity': 1})
                                      .toList(),
                                  'prices': selectedServices
                                      .map((service) => {'name': service, 'price': services[service]!})
                                      .toList(),
                                  'total': selectedTotal,
                                },
                                data: widget.data,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE0AC53),
                      ),
                      child: const Text(
                        'Payment',
                        style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

