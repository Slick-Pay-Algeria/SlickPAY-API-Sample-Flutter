import 'package:flutter/material.dart';
import 'package:slickpay_api/screens/transfer_screen/calcul_commission_screen.dart';
import 'package:slickpay_api/screens/transfer_screen/transfers_list_screen.dart';
import 'create_transfer_screen.dart';

class TransfersScreen extends StatelessWidget {
  const TransfersScreen({super.key});

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
                      builder: (context) => const TransferListScreen()),
                );
              },
              child: const Text("List of Transfers")),
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
                    builder: (context) => const TransferCreationScreen(),
                  ),
                );
              },
              child: const Text("Create Transfer")),
        ],
      ),
    );
  }
}
