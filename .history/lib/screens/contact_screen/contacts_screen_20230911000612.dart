import 'package:flutter/material.dart';
import 'package:slickpayapi/slickpayapi.dart';

import 'create_contact_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  Future<List<Contact>>? contacts;
  @override
  void initState() {
    contacts = ContactRepository.instance
        .fetchContacts(); // Call fetchAccounts() here to fetch data.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ContactCreationScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: FutureBuilder<List<Contact>>(
        future: contacts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the data, you can show a loading indicator.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there's an error, display an error message.
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // If there's no data or the data is empty, display a message.
            return const Text("No accounts available.");
          } else {
            // If data is available, display it in the ListView.builder.
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Contact contact = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(),
                    title: Text("${contact.firstName} ${contact.lastName}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${contact.rib} "),
                        Text("${contact.address} "),
                           Text("${contact..} "),
                      ],
                    ), // Display the account name.
                    trailing: const Icon(Icons.more_vert),
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
