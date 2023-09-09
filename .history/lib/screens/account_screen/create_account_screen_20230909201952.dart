 // ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:slickpayapi/slickpayapi.dart';
  
class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({Key? key}) : super(key: key);

  @override
  _AccountCreationScreenState createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> {
  TextEditingController ribController = TextEditingController();
  TextEditingController titleController = TextEditingController();
   TextEditingController lastnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  
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
              controller: ribController,
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
                await TransferRepository.instance.createTransfer(
                  amount: 1000,
                  contact: "4dcbea76-fdba-4486-8e07-7942d368641f",
                  url: "https://my-website.com/thank-you-page",
                );
              },
              child: const Text("Create Transfer"),
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
