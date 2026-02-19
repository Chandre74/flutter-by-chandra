import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShipmentScreen(),
    );
  }
}

/// ----------------------
/// SHIPMENT MODEL
/// ----------------------
class Shipment {
  final String id;
  final String pickupAddress;
  final String deliveryAddress;
  String status;

  Shipment({
    required this.id,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.status,
  });
}

/// ----------------------
/// SHIPMENT SCREEN
/// ----------------------
class ShipmentScreen extends StatefulWidget {
  const ShipmentScreen({super.key});

  @override
  State<ShipmentScreen> createState() => _ShipmentScreenState();
}

class _ShipmentScreenState extends State<ShipmentScreen> {
  //  10 Shipments
  List<Shipment> shipments = [
    Shipment(
      id: "SHP001",
      pickupAddress: "12 Main Street",
      deliveryAddress: "45 Green Road",
      status: "Pending",
    ),
    Shipment(
      id: "SHP002",
      pickupAddress: "78 Blue Ave",
      deliveryAddress: "90 Sunset Blvd",
      status: "Shipped",
    ),
    Shipment(
      id: "SHP003",
      pickupAddress: "11 Oak Street",
      deliveryAddress: "22 Pine Road",
      status: "Delivered",
    ),
    Shipment(
      id: "SHP004",
      pickupAddress: "34 Lake View",
      deliveryAddress: "56 Hill Street",
      status: "Pending",
    ),
    Shipment(
      id: "SHP005",
      pickupAddress: "99 River Road",
      deliveryAddress: "10 Forest Lane",
      status: "Shipped",
    ),
    Shipment(
      id: "SHP006",
      pickupAddress: "5 Market Street",
      deliveryAddress: "8 King Avenue",
      status: "Delivered",
    ),
    Shipment(
      id: "SHP007",
      pickupAddress: "44 Sunset Drive",
      deliveryAddress: "77 Sunrise Blvd",
      status: "Pending",
    ),
    Shipment(
      id: "SHP008",
      pickupAddress: "100 Apple St",
      deliveryAddress: "200 Orange Rd",
      status: "Shipped",
    ),
    Shipment(
      id: "SHP009",
      pickupAddress: "300 Banana Ave",
      deliveryAddress: "400 Mango Blvd",
      status: "Delivered",
    ),
    Shipment(
      id: "SHP010",
      pickupAddress: "15 Cedar Lane",
      deliveryAddress: "25 Maple Street",
      status: "Pending",
    ),
  ]; // randomized through chatbot

  void updateStatus(int index) {
    setState(() {
      if (shipments[index].status == "Pending") {
        shipments[index].status = "Shipped";
      } else if (shipments[index].status == "Shipped") {
        shipments[index].status = "Delivered";
      } else {
        shipments[index].status = "Pending";
      }
    });
  }

  Color getStatusColor(String status) {
    if (status == "Delivered") return Colors.green;
    if (status == "Shipped") return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipment List"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: shipments.length,
        itemBuilder: (context, index) {
          final shipment = shipments[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shipment ID: ${shipment.id}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text("Pickup: ${shipment.pickupAddress}"),
                  Text("Delivery: ${shipment.deliveryAddress}"),

                  const SizedBox(height: 8),

                  Text(
                    "Status: ${shipment.status}",
                    style: TextStyle(
                      color: getStatusColor(shipment.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => updateStatus(index),
                      child: const Text("Update Status"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
