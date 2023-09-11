import 'package:flutter/material.dart';
import 'package:slickpayapi/slickpayapi.dart';

class AggregationsListScreen extends StatefulWidget {
  const AggregationsListScreen({super.key});

  @override
  State<AggregationsListScreen> createState() => _AggregationsListScreenState();
}

class _AggregationsListScreenState extends State<AggregationsListScreen> {
  Future<List<Aggregation>>? agregations;
  @override
  void initState() {
    agregations = AggregationRepository.instance.fetchAggregations();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aggregations"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          AggregationRepository.instance.createAggregation(
              url: "https://my-website.com/thank-you-page",
              total: 20000,
              contacts: [
                {"uuid": "864efcd3-9fef-4da5-67ec-bc28fd7e719b", "amount": 50},
                {"uuid": "f23bde3f-aac9-4dfc-7e06-5bf02e7f5967", "amount": 50}
              ]);
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Aggregation>>(
        future: agregations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the data, you can show a loading indicator.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there's an error, display an error message.
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // If there's no data or the data is empty, display a message.
            return const Center(child: Text("No Aggregations available."));
          } else {
            //   return Container();
            // If data is available, display it in the ListView.builder.
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Aggregation aggregation = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(),
                    title: Text("${aggregation.serial}  "),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${aggregation..amount} "),
                        Text("${aggregation..status} "),
                      ],
                    ), // Display the account name.
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        // Handle menu item selection here
                      },
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                     /*      PopupMenuItem<String>(
                            onTap: () => AggregationRepository.instance
                                .updateAggregation(
                              id: 12,
                              amount: 1000,
                              contact: "37990d08-fc51-4c32-ad40-1552d13c00d1",
                              url: "https://my-website.com/thank-you-page",
                            ),
                            value: 'Update ',
                            child: const Text('Update'),
                          ), */
                          PopupMenuItem<String>(
                            onTap: () => AggregationRepository.instance
                                .deleteAggregation("2"),
                            value: 'Delete',
                            child: const Text('Delete'),
                          ),
                        ];
                      },
                      child: const IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed:
                            null, // Set onPressed to null to disable the IconButton
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
