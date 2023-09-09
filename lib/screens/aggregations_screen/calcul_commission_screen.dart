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
    setState(() => isLoading = true);
    String amount = amountController.text;

    if (amount.isEmpty) {
      setState(() {
        commissionResult = "Please enter an amount.";
      });
      return;
    }

    try {
      final response = await ApiClient.instance.post(
        "${API.aggregations}/commission",
        jsonEncode({
          "success": 1,
          "amount": 10000,
          "commission": 200,
          "total": 10200,
          "contacts": [
            {
              "uuid": "864efcd3-9fef-4da5-67ec-bc28fd7e719b",
              "amount": 5000,
              "commission": 100
            },
            {
              "uuid": "f23bde3f-aac9-4dfc-7e06-5bf02e7f5967",
              "amount": 5000,
              "commission": 100
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        setState(() => isLoading = false);
        final responseData = json.decode(response.body);

        setState(() {
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
              decoration: InputDecoration(
                labelText: "Amount",
              ),
            ),
          const  SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calculateCommission,
              child: Text("Calculate Commission"),
            ),
            const SizedBox(height: 16.0),
            isLoading
                ? const CircularProgressIndicator()
                : Text(
                    commissionResult,
                    style: TextStyle(fontSize: 18),
                  ),
          ],
        ),
      ),
    );
  }
}
