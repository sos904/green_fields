import 'package:flutter/material.dart';

class PickupHistoryScreen extends StatelessWidget {
  const PickupHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pickup History"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          PickupCard(date: "12 Jan 2026", status: "Completed"),
          PickupCard(date: "18 Jan 2026", status: "Pending"),
        ],
      ),
    );
  }
}

class PickupCard extends StatelessWidget {
  final String date;
  final String status;

  const PickupCard({super.key, required this.date, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.delete, color: Colors.green),
        title: Text("Pickup on $date"),
        subtitle: Text("Status: $status"),
      ),
    );
  }
}
