import 'package:flutter/material.dart';
import 'package:slickpay_api/screens/transfer_screen/calcul_commission_screen.dart';
 
import 'aggregations_list_screen.dart';
import 'create_pay_aggregation_screen.dart';

class AggregationsScreen extends StatelessWidget {
  const AggregationsScreen({super.key});

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
                      builder: (context) => const AggregationsListScreen()),
                );
              },
              child: const Text("List of aggregations")),
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
                      builder: (context) =>
                          const PayAggregationCreationScreen()),
                );
              },
              child: const Text("Create aggregation")),
        ],
      ),
    );
  }
}
