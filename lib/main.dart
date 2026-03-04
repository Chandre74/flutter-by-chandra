import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'day4.dart';
import 'package:logistics_driver_app/Providers/shipment_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ShipmentProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
