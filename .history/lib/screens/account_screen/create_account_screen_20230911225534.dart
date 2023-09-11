// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:slickpay_api/screens/home_screen.dart';
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
        title: const Text("Account Creation"),
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
                labelText: "Rib",
              ),
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              controller: lastnameController,
              decoration: const InputDecoration(
                labelText: "Lastname",
              ),
            ),
            TextField(
              controller: firstnameController,
              decoration: const InputDecoration(
                labelText: "Firstname",
              ),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Address",
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (ribController.text.isNotEmpty &&
                    titleController.text.isNotEmpty &&
                    lastnameController.text.isNotEmpty &&
                    firstnameController.text.isNotEmpty &&
                    addressController.text.isNotEmpty) {
                  await AccountRepository.instance
                      .createAccount(
                    rib: ribController.text,
                    title: titleController.text,
                    lastname: lastnameController.text,
                    firstname: firstnameController.text,
                    address: addressController.text,
                  )
                      .then((result) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('successfuly!'),
                      backgroundColor: Colors.teal,
                    ));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('one or all the fields are empty!'),
                    backgroundColor: Colors.red,
                  ));
                }
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
