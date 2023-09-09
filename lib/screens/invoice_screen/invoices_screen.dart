import 'package:flutter/material.dart';
import 'package:slickpay_api/screens/invoice_screen/invoices_list_screen.dart';
import 'calcul_commission_screen.dart';
import 'create_invoice_screen.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InvoicesListScreen()),
                );
              },
              child: const Text("List of Invoices")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalculCommissionScreen()),
                );
              },
              child: const Text("Calcul Commission")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InvoiceCreationScreen(),
                  ),
                );
              },
              child: const Text("Create Invoice")),
        ],
      ),
    );
  }
}
