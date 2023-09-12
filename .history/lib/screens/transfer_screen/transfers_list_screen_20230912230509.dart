import 'package:flutter/material.dart';
import 'package:slickpayapi/slickpayapi.dart';
 import 'create_transfer_screen.dart';

class TransferListScreen extends StatefulWidget {
  const TransferListScreen({super.key});

  @override
  State<TransferListScreen> createState() => _TransferListScreenState();
}

class _TransferListScreenState extends State<TransferListScreen> {
  Future<List<Transfer>>? transfers;
  @override
  void initState() {
    transfers = TransferRepository.instance.getTransfers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfers"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TransferCreationScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Transfer>>(
        future: transfers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the data, you can show a loading indicator.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there's an error, display an error message.
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // If there's no data or the data is empty, display a message.
            return const Text("No Transfer available.");
          } else {
            // If data is available, display it in the ListView.builder.
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Transfer transfer = snapshot.data![index];
                return Card(
                  child: InkWell(
                    onTap: () {
               /*        TransferRepository.instance
                          .getTransferById(id: transfer.id!); */
                    },
                    child: ListTile(
                      leading: const CircleAvatar(),
                      title: Text("${transfer.firstName} ${transfer.lastName}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${transfer.rib} "),
                          Text("${transfer.address} "),
                        ],
                      ), // Display the account name.
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          // Handle menu item selection here
                        },
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              onTap: () => TransferRepository.instance
                                  .updateTransfer(
                                      id: 12,
                                      amount: 1000,
                                      contact:
                                          "37990d08-fc51-4c32-ad40-1552d13c00d1",
                                      url:
                                          "https://my-website.com/thank-you-page"),
                              value: 'Update ',
                              child: const Text('Update'),
                            ),
                            PopupMenuItem<String>(
                              onTap: () => TransferRepository.instance
                                  .deleteTransfer(id: 2),
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
