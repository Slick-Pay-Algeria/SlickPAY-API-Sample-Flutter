// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:slickpayapi/slickpayapi.dart';

import '../home_screen.dart';

class TransferCreationScreen extends StatefulWidget {
  const TransferCreationScreen({Key? key}) : super(key: key);

  @override
  _TransferCreationScreenState createState() => _TransferCreationScreenState();
}

class _TransferCreationScreenState extends State<TransferCreationScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController accountController = TextEditingController();

  String resultMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer Creation"),
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("keep in mind use Account or Contact UUID  to create Transfer"),
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
              controller: accountController,
              decoration: const InputDecoration(
                labelText: "Account",
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
                if (amountController.text.isNotEmpty &&
                    (contactController.text.isNotEmpty || accountController.text.isNotEmpty )&&
                    urlController.text.isNotEmpty) {
                  await TransferRepository.instance
                      .createTransfer(
                    amount: double.parse(amountController.text),
                    contact: contactController.text,
                    account: accountController.text,
                    url: "https://my-website.com/thank-you-page",
                  )
                      .then((result) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('successfuly created!'),
                      backgroundColor: Colors.teal,
                    ));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(error.toString()),
                      backgroundColor: Colors.red,
                    ));
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('one or all the fields are empty!'),
                    backgroundColor: Colors.red,
                  ));
                }
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
