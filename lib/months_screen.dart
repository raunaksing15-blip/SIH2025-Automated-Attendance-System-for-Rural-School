
import 'package:flutter/material.dart';

class MonthsScreen extends StatelessWidget {
  const MonthsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Months'),
      ),
      body: const Center(
        child: Text('Months Screen'),
      ),
    );
  }
}
