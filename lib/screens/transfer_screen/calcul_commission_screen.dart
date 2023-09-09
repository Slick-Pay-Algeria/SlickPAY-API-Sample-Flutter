import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slickpay_api/api.dart';
import 'package:slickpay_api/network.dart';

class CalculCommissionScreen extends StatefulWidget {
  const CalculCommissionScreen({super.key});

  @override
  State<CalculCommissionScreen> createState() => _CalculCommissionScreenState();
}

class _CalculCommissionScreenState extends State<CalculCommissionScreen> {
  TextEditingController amountController = TextEditingController();
  String commissionResult = "";
  bool isLoading = false;
  void calculateCommission() async {
    setState(() {
      isLoading = true;
    });
    String amount = amountController.text;

    if (amount.isEmpty) {
      setState(() {
        commissionResult = "Please enter an amount.";
      });
      return;
    }

    try {
      final response = await ApiClient.instance.post(
        "${API.transfers}/commission",
        jsonEncode({
          "amount": amount,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (kDebugMode) {}
        setState(() {
          isLoading = false;
          commissionResult = "Commission: ${responseData['commission']} DA";
        });
      } else {
        if (kDebugMode) {
          print("Error: ${response.body}");
          print("Error: ${response.statusCode}");
        }
        setState(() {
          commissionResult = "Error: Something went wrong.";
        });
      }
    } catch (e) {
      setState(() {
        commissionResult = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Commission Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calculateCommission,
              child: const Text("Calculate Commission"),
            ),
            const SizedBox(height: 16.0),
            isLoading
                ? const CircularProgressIndicator()
                : Text(
                    commissionResult,
                    style: const TextStyle(fontSize: 18),
                  ),
          ],
        ),
      ),
    );
  }
}
