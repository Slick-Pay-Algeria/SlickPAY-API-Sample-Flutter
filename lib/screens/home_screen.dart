import 'package:flutter/material.dart';
import 'package:slickpay_api/screens/account_screen/accounts_screen.dart';
import 'package:slickpay_api/screens/aggregations_screen/aggregations_screen.dart';
import 'package:slickpay_api/screens/transfer_screen/transfers_screen.dart';

import 'contact_screen/contacts_screen.dart';
import 'invoice_screen/invoices_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const AccountsScreen(),
    const ContactsScreen(),
    const AggregationsScreen(),
    const TransfersScreen(),
    const InvoicesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SlickPAY API samples'),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.amber,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.account_box,
                    color: Colors.black,
                  ),
                  Text("Account")
                ],
              ),
              label: 'Tab 1',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.contact_page,
                    color: Colors.black,
                  ),
                  Text("Contact")
                ],
              ),
              label: 'Tab 2',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.payment,
                    color: Colors.black,
                  ),
                  Text("Payments")
                ],
              ),
              label: 'Tab 3',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.transfer_within_a_station,
                    color: Colors.black,
                  ),
                  Text("Transfer")
                ],
              ),
              label: 'Tab 4',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.inventory,
                    color: Colors.black,
                  ),
                  Text("Invoice")
                ],
              ),
              label: 'Tab 5',
            ),
          ],
        ),
      ),
    );
  }
}

class TabScreen extends StatelessWidget {
  final String title;
  final Color color;

  const TabScreen({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}
