import 'package:flutter/material.dart';
import 'package:slickpayapi/slickpayapi.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  Future<List<Account>>? accounts;
  @override
  void initState() {
    accounts = AccountRepository.instance
        .fetchAccounts(); // Call fetchAccounts() here to fetch data.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          AccountRepository.instance
              .createAccount(
                rib: "12345678912345678900",
                title: "Lorem Ipsum",
                lastname: "Lorem",
                firstname: "Ipsum",
                address: "Lorem Ipsum Address",
              )
              .then((result) {});
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Accounts"),
      ),
      body: FutureBuilder<List<Account>>(
        future: accounts,
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
                Account account = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(),
                    title: Text("${account.firstname} ${account.lastname}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${account.rib} "),
                        Text("${account.address} "),
                      ],
                    ), // Display the account name.
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        // Handle menu item selection here
                      },
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'Update ',
                            child: InkWell(
                                onTap: () => AccountRepository.instance
                                    .updateAccount(account.id.toString()),
                                child: const Text('Update')),
                          ),
                          PopupMenuItem<String>(
                            value: 'Delete',
                            child: InkWell(
                                onTap: () => AccountRepository.instance
                                    .deleteAccount(account.id.toString()),
                                child: const Text('Delete')),
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
