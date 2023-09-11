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
        title: const Text("Aggregation Creation"),
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
                decoration: const InputDecoration(
                  labelText: "Total",
                ),
              ),
              TextField(
                controller: urlController,
                decoration: const InputDecoration(
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
                        TextField(
                          controller: amountController,
                          decoration: const InputDecoration(
                              labelText: 'Amount Contact'),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            addItemToList();
                          },
                          child: const Text('Add Contact to List'),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: itemsList.length,
                            itemBuilder: (context, index) {
                              final item = itemsList[index];
                              return ListTile(
                                title: Text(item['uuid']),
                                subtitle: Text('Amount: ${item['amount']} DA'),
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
                  if (totalController.text.isNotEmpty &&
                      urlController.text.isNotEmpty &&
                      itemsList.isNotEmpty) {
                    try {
                      final res = await AggregationRepository.instance
                          .createAggregation(
                              total: double.parse(totalController.text),
                              url: "https://my-website.com/thank-you-page",
                              contacts: itemsList);

                      if (res.statusCode == 422) {}
                    } catch (e) {}
                  } else {
                    const snackBar = SnackBar(
                      content: Text('Check the fields !'),
                    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
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

    if (itemUuid.isNotEmpty && itemAmount > 0) {
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
