import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slickpay_api/screens/account_screen/create_account_screen.dart';
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AccountCreationScreen(),
            ),
          );
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
                    trailing: SizedBox(
                      width: 80,
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                FlutterClipboard.copy('hello flutter friends')
                                    .then((value) => Fluttertoast.showToast(
                                        msg: "has been copied !",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.teal,
                                        textColor: Colors.white,
                                        fontSize: 16.0),);
                              },
                              child: Icon(Icons.copy)),
                          PopupMenuButton<String>(
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
                        ],
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
