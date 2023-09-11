// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:slickpay_api/screens/home_screen.dart';
import 'package:slickpayapi/slickpayapi.dart';

class InvoiceCreationScreen extends StatefulWidget {
  const InvoiceCreationScreen({Key? key}) : super(key: key);

  @override
  _InvoiceCreationScreenState createState() => _InvoiceCreationScreenState();
}

class _InvoiceCreationScreenState extends State<InvoiceCreationScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final List<Map<String, dynamic>> itemsList = [];
  String resultMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Creation"),
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
      body: SingleChildScrollView(
        child: Padding(
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
              const SizedBox(height: 10.0),
              Container(
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration:
                              const InputDecoration(labelText: 'Item Name'),
                        ),
                        TextField(
                          controller: priceController,
                          decoration: const InputDecoration(labelText: 'Price'),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: quantityController,
                          decoration:
                              const InputDecoration(labelText: 'Quantity'),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            addItemToList();
                          },
                          child: const Text('Add Invoice to List'),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: itemsList.length,
                            itemBuilder: (context, index) {
                              final item = itemsList[index];
                              return ListTile(
                                title: Text(item['name']),
                                subtitle: Text(
                                    'Price: ${item['price']} DA, Quantity: ${item['quantity']}'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (amountController.text.isNotEmpty &&
                      contactController.text.isNotEmpty &&
                      itemsList.isNotEmpty) {
                    await InvoiceRepository.instance
                        .createInvoice(
                            amount: double.parse(amountController.text),
                            contact: contactController.text,
                            url: "https://my-website.com/thank-you-page",
                            items: itemsList)
                        .then((value) { Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            ))}; 
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('one or all the fields are empty!'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: const Text("Create Invoice"),
              ),
              const SizedBox(height: 10.0),
              Text(
                resultMessage,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addItemToList() {
    final itemName = nameController.text;
    final itemPrice = double.tryParse(priceController.text) ?? 0;
    final itemQuantity = int.tryParse(quantityController.text) ?? 0;

    if (itemName.isNotEmpty && itemPrice > 0 && itemQuantity > 0) {
      setState(() {
        final newItem = {
          'name': itemName,
          'price': itemPrice,
          'quantity': itemQuantity,
        };
        itemsList.add(newItem);
        nameController.clear();
        priceController.clear();
        quantityController.clear();
      });
    }
  }
}
