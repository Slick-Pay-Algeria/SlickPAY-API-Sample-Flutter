import 'package:flutter/material.dart';
import 'package:slickpayapi/slickpayapi.dart';

class PayAggregationCreationScreen extends StatefulWidget {
  const PayAggregationCreationScreen({Key? key}) : super(key: key);

  @override
  _PayAggregationCreationScreenState createState() =>
      _PayAggregationCreationScreenState();
}

class _PayAggregationCreationScreenState
    extends State<PayAggregationCreationScreen> {
  TextEditingController totalController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  final TextEditingController uuidController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
   final List<Map<String, dynamic>> itemsList = [];

  String resultMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aggregation Creation"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: totalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
              ),
              TextField(
                controller: contactController,
                decoration: InputDecoration(
                  labelText: "Contact",
                ),
              ),
              TextField(
                controller: urlController,
                decoration: InputDecoration(
                  labelText: "URL",
                ),
              ),
              const SizedBox(height: 16.0),
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
                          controller: uuidController,
                          decoration:
                              const InputDecoration(labelText: 'Uuid Contact'),
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
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  await AggregationRepository.instance.createAggregation(
                    total: double.parse(totalController.text),
                    url: "https://my-website.com/thank-you-page",
                    contacts: [
                      {
                        "uuid": "864efcd3-9fef-4da5-67ec-bc28fd7e719b",
                        "amount": 50
                      },
                      {
                        "uuid": "f23bde3f-aac9-4dfc-7e06-5bf02e7f5967",
                        "amount": 50
                      }
                    ],
                  );
                },
                child: Text("Create Aggregation"),
              ),
              const SizedBox(height: 16.0),
              Text(
                resultMessage,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addItemToList() {
    final itemUuid = uuidController.text;
    final itemAmount = double.tryParse(amountController.text) ?? 0;

    if (itemName.isNotEmpty && itemAmount > 0) {
      setState(() {
        final newItem = {
          'uuid': itemUuid,
          'amount': itemAmount,
        };
        itemsList.add(newItem);
        uuidController.clear();
        amountController.clear();
       });
    }
  }
}
