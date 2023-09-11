// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:slickpayapi/slickpayapi.dart';

class TransferCreationScreen extends StatefulWidget {
  const TransferCreationScreen({Key? key}) : super(key: key);

  @override
  _TransferCreationScreenState createState() => _TransferCreationScreenState();
}

class _TransferCreationScreenState extends State<TransferCreationScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  String resultMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer Creation"),
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
            TextField(
              controller: contactController,
              decoration: const InputDecoration(
                labelText: "Contact",
              ),
            ),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: "URL",
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                TransferRepository.instance
                    .createTransfer(
                      amount: amountController.text,
                      contact: "",
                      url: "url",
                    )
                    .then((result) {});
                await AccountRepository.instance
                    .createAccount(
                      rib: ribController.text,
                      title: "Lorem Ipsum",
                      lastname: "Lorem",
                      firstname: "Ipsum",
                      address: "Lorem Ipsum Address",
                    )
                    .then((result) {});
              },
              child: const Text("Create Account"),
            ),
            const SizedBox(height: 16.0),
            Text(
              resultMessage,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
