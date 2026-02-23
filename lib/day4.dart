import 'package:flutter/material.dart';
import 'package:logistics_driver_app/day3.dart';

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
        title: const Text("Login"),
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

  final List<ShipmentDetailsModel> shipmentDetailsList = [
    ShipmentDetailsModel(
      id: "SHP001",
      pickupAddress: "Kathmandu",
      deliveryAddress: "Pokhara",
      status: "In Transit",
      senderName: "Chandra Mani",
      receiverName: "Ram Sharma",
      weight: 5.5,
      price: 1200,
      createdDate: DateTime.now(),
      estimatedDelivery: DateTime.now().add(Duration(days: 3)),
      isFragile: true,
      notes: "Handle with care",
    ),
    ShipmentDetailsModel(
      id: "SHP002",
      pickupAddress: "Biratnagar",
      deliveryAddress: "Chitwan",
      status: "Delivered",
      senderName: "Sita Rai",
      receiverName: "Hari Karki",
      weight: 2.3,
      price: 800,
      createdDate: DateTime.now().subtract(Duration(days: 4)),
      estimatedDelivery: DateTime.now().subtract(Duration(days: 1)),
      isFragile: false,
      notes: "Left at front desk",
    ),
    ShipmentDetailsModel(
      id: "SHP003",
      pickupAddress: "Butwal",
      deliveryAddress: "Nepalgunj",
      status: "Pending",
      senderName: "Ramesh Thapa",
      receiverName: "Bina Gurung",
      weight: 7.0,
      price: 1500,
      createdDate: DateTime.now(),
      estimatedDelivery: DateTime.now().add(Duration(days: 5)),
      isFragile: true,
      notes: "Glass items inside",
    ),
    ShipmentDetailsModel(
      id: "SHP004",
      pickupAddress: "Lalitpur",
      deliveryAddress: "Dharan",
      status: "In Transit",
      senderName: "Anita Sharma",
      receiverName: "Kamal Basnet",
      weight: 3.2,
      price: 950,
      createdDate: DateTime.now(),
      estimatedDelivery: DateTime.now().add(Duration(days: 2)),
      isFragile: false,
      notes: "Standard delivery",
    ),
    ShipmentDetailsModel(
      id: "SHP005",
      pickupAddress: "Janakpur",
      deliveryAddress: "Hetauda",
      status: "Cancelled",
      senderName: "Prakash Yadav",
      receiverName: "Suman KC",
      weight: 4.1,
      price: 1100,
      createdDate: DateTime.now().subtract(Duration(days: 2)),
      estimatedDelivery: DateTime.now().add(Duration(days: 2)),
      isFragile: false,
      notes: "Customer cancelled",
    ),
    ShipmentDetailsModel(
      id: "SHP006",
      pickupAddress: "Bhaktapur",
      deliveryAddress: "Itahari",
      status: "Delivered",
      senderName: "Maya Shrestha",
      receiverName: "Dipesh Limbu",
      weight: 6.8,
      price: 1700,
      createdDate: DateTime.now().subtract(Duration(days: 6)),
      estimatedDelivery: DateTime.now().subtract(Duration(days: 2)),
      isFragile: true,
      notes: "Electronics item",
    ),
    ShipmentDetailsModel(
      id: "SHP007",
      pickupAddress: "Dang",
      deliveryAddress: "Birtamod",
      status: "In Transit",
      senderName: "Suraj Bhandari",
      receiverName: "Nisha Tamang",
      weight: 1.9,
      price: 600,
      createdDate: DateTime.now(),
      estimatedDelivery: DateTime.now().add(Duration(days: 4)),
      isFragile: false,
      notes: "Clothing items",
    ),
    ShipmentDetailsModel(
      id: "SHP008",
      pickupAddress: "Tansen",
      deliveryAddress: "Gorkha",
      status: "Pending",
      senderName: "Bishal Adhikari",
      receiverName: "Alina Rana",
      weight: 8.4,
      price: 2000,
      createdDate: DateTime.now(),
      estimatedDelivery: DateTime.now().add(Duration(days: 6)),
      isFragile: true,
      notes: "Heavy machinery parts",
    ),
    ShipmentDetailsModel(
      id: "SHP009",
      pickupAddress: "Dhangadhi",
      deliveryAddress: "Surkhet",
      status: "In Transit",
      senderName: "Kiran Joshi",
      receiverName: "Manoj Rawat",
      weight: 2.7,
      price: 750,
      createdDate: DateTime.now(),
      estimatedDelivery: DateTime.now().add(Duration(days: 3)),
      isFragile: false,
      notes: "Documents parcel",
    ),
    ShipmentDetailsModel(
      id: "SHP010",
      pickupAddress: "Kathmandu",
      deliveryAddress: "Birgunj",
      status: "Delivered",
      senderName: "Rita Koirala",
      receiverName: "Sandeep Shah",
      weight: 5.0,
      price: 1300,
      createdDate: DateTime.now().subtract(Duration(days: 5)),
      estimatedDelivery: DateTime.now().subtract(Duration(days: 1)),
      isFragile: true,
      notes: "Fragile kitchenware",
    ),
  ];

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
