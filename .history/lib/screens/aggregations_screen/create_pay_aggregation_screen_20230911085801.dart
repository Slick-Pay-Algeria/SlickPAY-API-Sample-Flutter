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
  TextEditingController amountController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  String resultMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aggregation Creation"),
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
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                await AggregationRepository.instance.createAggregation(
                  total: doubel.,
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
            SizedBox(height: 16.0),
            Text(
              resultMessage,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
