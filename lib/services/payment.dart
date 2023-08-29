import 'package:doctor_patient/config.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment {
  Razorpay _razorpay = Razorpay();

  var options = {
    'key': '<YOUR_KEY_HERE>',
    'amount': 100,
    'name': 'Acme Corp.',
    'description': 'Fine T-Shirt',
    'prefill': {
      'contact': '8888888888',
      'email': 'test@razorpay.com'
    }
  };
  static Future<Map<dynamic,dynamic>> startPayment({
    @required String? amount,
    @required String? name, // name of person/item
    @required String? image, // doctor image
    @required String? email, // doctor image
    @required String? contact
  }) async {
    final finalAmount = (int.parse(amount!) * 100).toString();
    Map<String, dynamic> options = new Map();
    options.putIfAbsent("name", () => name);
    options.putIfAbsent("image", () => image);
    options.putIfAbsent("description", () => "Pay for this doctor");
    options.putIfAbsent("amount", () => finalAmount);
    options.putIfAbsent("email", () => email);
    options.putIfAbsent("contact", () => contact);
    //Must be a valid HTML color.
    options.putIfAbsent("theme", () => UIData.primaryColorHex);
    //Notes -- OPTIONAL
    // Map<String, String> notes = new Map();
    // notes.putIfAbsent('key', () => "value");
    // notes.putIfAbsent('randomInfo', () => "haha");
    // options.putIfAbsent("notes", () => notes);
    options.putIfAbsent("api_key", () => Config.getRazorPayApiKey());
    Map<dynamic, dynamic> paymentResponse = new Map();
    // paymentResponse = await _razorpay.open(options);
    return paymentResponse;
  }
}