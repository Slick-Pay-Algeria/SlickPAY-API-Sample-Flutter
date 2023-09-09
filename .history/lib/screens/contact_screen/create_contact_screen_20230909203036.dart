// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:slickpayapi/slickpayapi.dart';

class ContactCreationScreen extends StatefulWidget {
  const ContactCreationScreen({Key? key}) : super(key: key);

  @override
  _ContactCreationScreenState createState() => _ContactCreationScreenState();
}

class _ContactCreationScreenState extends State<ContactCreationScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController titleController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String resultMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Creation"),
      ),
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Email",
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
                await ContactRepository.instance
                    .createContact(
                  rib: emailController.text,
                  title: "Lorem Ipsum",
                  lastname: "Lorem",
                  firstname: "Ipsum",
                  address: "Lorem Ipsum Address",
                  email: "lorem@ipsum.com",
                )
                    .then((result) {
                  Navigator.pop(context);
                });
              },
              child: const Text("Create Contact"),
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
