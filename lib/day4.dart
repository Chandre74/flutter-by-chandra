import 'package:flutter/material.dart';
import 'package:logistics_driver_app/data/model/shipment_details_model.dart';
import 'package:logistics_driver_app/data/raw_datas/shipment_details.dart';
import 'package:logistics_driver_app/day3.dart';
import 'package:logistics_driver_app/maps.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen()),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("LogisticsAPP"),
        titleTextStyle: TextStyle(
          color: Colors.amber,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: "Enter your Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Enter your Password",
                border: const OutlineInputBorder(),

                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 10,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen(),
                    ),
                  );
                },
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 20),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.amber),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Your Name"),
              accountEmail: Text("your@email.com"),
              decoration: BoxDecoration(color: Colors.black),
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("History"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.green),
              title: const Text("Live Tracking"),
              onTap: () {
                Navigator.pop(context); // Close drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LiveTrackingScreen(),
                  ),
                );
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),

      body: const ShipmentScreen(),
    );
  }
}

class ShipmentDetailsScreen extends StatelessWidget {
  final String id;

  ShipmentDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final ShipmentDetailsModel shipment = shipmentDetailsList.firstWhere(
      (item) => item.id == id,
    );
    return Scaffold(
      appBar: AppBar(title: Text("Shipment ${shipment.id}")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Status: ${shipment.status}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Text("Pickup: ${shipment.pickupAddress}"),
            Text("Delivery: ${shipment.deliveryAddress}"),
            const SizedBox(height: 10),

            Text("Sender: ${shipment.senderName}"),
            Text("Receiver: ${shipment.receiverName}"),
            const SizedBox(height: 10),

            Text("Weight: ${shipment.weight} kg"),
            Text("Price: Rs. ${shipment.price}"),
            const SizedBox(height: 10),

            Text(
              "Created: ${shipment.createdDate.toLocal().toString().split(' ')[0]}",
            ),
            Text(
              "Estimated Delivery: ${shipment.estimatedDelivery.toLocal().toString().split(' ')[0]}",
            ),
            const SizedBox(height: 10),

            Text("Fragile: ${shipment.isFragile ? "Yes" : "No"}"),
            const SizedBox(height: 10),

            Text("Notes: ${shipment.notes}"),
          ],
        ),
      ),
    );
  }
}
