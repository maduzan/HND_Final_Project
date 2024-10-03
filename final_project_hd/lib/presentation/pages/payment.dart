import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pay extends StatefulWidget {
  static const routeName = "/Pay";

  Pay({
    Key? key,
  }) : super(key: key);

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  String? selectedPackage;
  List<String> dropdownMenu = ['base', 'Gold', 'titan', 'common', 'gradient'];
  final _formKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String? userName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    priceController.text = '0';
  }

  void _updatePrice(String? package) {
    // Update the price based on the selected package
    switch (package) {
      case 'plumber':
        priceController.text = '1000';
        break;
      case 'carpenter':
        priceController.text = '2000';
        break;
      case 'builder':
        priceController.text = '3000';
        break;
      case 'Technition':
        priceController.text = '1500';
        break;
      case 'Electetion':
        priceController.text = '2500';
        break;
      default:
        priceController.text = '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Payment',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown Menu for Package Selection
              Center(
                child: Text(
                  'Select Worker',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Center(
                child: DropdownButton<String>(
                  value: selectedPackage,
                  hint: Text(
                    'Choose your package',
                    style: TextStyle(color: Colors.white),
                  ),
                  items: dropdownMenu.map((String package) {
                    return DropdownMenuItem<String>(
                      value: package,
                      child:
                          Text(package, style: TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPackage = newValue;
                      _updatePrice(
                          newValue); // Update price when package is selected
                    });
                  },
                  dropdownColor: Colors.black, // Set dropdown color
                ),
              ),

              SizedBox(height: 100),

              // Price Input
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[800], // Price field color
                ),
                keyboardType: TextInputType.number,
                readOnly: true,
              ),

              SizedBox(height: 20),

              // Card Number Input
              TextFormField(
                controller: cardNumberController,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Expiry Date Input
              TextFormField(
                controller: expiryDateController,
                decoration: InputDecoration(
                  labelText: 'Expiry Date (MM/YY)',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // CVV Input
              TextFormField(
                controller: cvvController,
                decoration: InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  }
                  return null;
                },
              ),

              SizedBox(height: 30),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the payment
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Processing Payment...'),
                        ),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of controllers
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
