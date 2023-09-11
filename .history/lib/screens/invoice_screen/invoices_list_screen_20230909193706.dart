import 'package:flutter/material.dart';
import 'package:slickpayapi/slickpayapi.dart';
import 'create_invoice_screen.dart';

class InvoicesListScreen extends StatefulWidget {
  const InvoicesListScreen({super.key});

  @override
  State<InvoicesListScreen> createState() => _InvoicesListScreenState();
}

class _InvoicesListScreenState extends State<InvoicesListScreen> {
  Future<List<Invoice>>? invoices;

  @override
  void initState() {
    invoices = InvoiceRepository.instance.fetchInvoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoices"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InvoiceCreationScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Invoice>>(
        future: invoices,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the data, you can show a loading indicator.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there's an error, display an error message.
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // If there's no data or the data is empty, display a message.
            return const Text("No Invoices available.");
          } else {
            // If data is available, display it in the ListView.builder.
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Invoice invoice = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(),
                    title: Text("${invoice.serial} "),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("${invoice.amount} :"),
                            Text("${invoice.status} "),
                          ],
                        ),
                        Text("${invoice.email} "),
                      ],
                    ), // Display the account name.
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        // Handle menu item selection here
                      },
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            onTap: () =>
                                InvoiceRepository.instance.updateInvoice(
                              id: 2,
                              amount: 1000,
                              contact: "37990d08-fc51-4c32-ad40-1552d13c00d1",
                              url: "https://my-website.com/thank-you-page",
                            ),
                            value: 'Update ',
                            child: const Text('Update'),
                          ),
                          PopupMenuItem<String>(
                            onTap: () =>
                                InvoiceRepository.instance.deleteInvoice(id: 2),
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
