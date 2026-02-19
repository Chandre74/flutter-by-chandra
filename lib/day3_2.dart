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
      home: DashboardScreen(),
    );
  }
}

/// ----------------------
/// FOOD ITEM MODEL
/// ----------------------
class FoodItem {
  final String name;
  final int price;
  final String servedType; // Hot or Cold
  String status; // Available, Unavailable, Pre-Order

  FoodItem({
    required this.name,
    required this.price,
    required this.servedType,
    required this.status,
  });
}

/// SAMPLE FOOD LIST
List<FoodItem> foods = [
  FoodItem(
    name: "Butter Chicken",
    price: 350,
    servedType: "Hot",
    status: "Available",
  ),
  FoodItem(
    name: "Paneer Tikka",
    price: 280,
    servedType: "Hot",
    status: "Unavailable",
  ),
  FoodItem(
    name: "Veg Biryani",
    price: 220,
    servedType: "Hot",
    status: "Available",
  ),
  FoodItem(
    name: "Chow Mein",
    price: 180,
    servedType: "Hot",
    status: "Pre-Order",
  ),
  FoodItem(
    name: "Fried Rice",
    price: 200,
    servedType: "Hot",
    status: "Available",
  ),
  FoodItem(name: "Momos", price: 150, servedType: "Hot", status: "Available"),
  FoodItem(
    name: "Thukpa",
    price: 170,
    servedType: "Hot",
    status: "Unavailable",
  ),
  FoodItem(
    name: "Dal Bhat",
    price: 300,
    servedType: "Hot",
    status: "Available",
  ),
  FoodItem(
    name: "Sel Roti",
    price: 120,
    servedType: "Hot",
    status: "Available",
  ),
  FoodItem(
    name: "Mango Lassi",
    price: 120,
    servedType: "Cold",
    status: "Available",
  ),
  FoodItem(
    name: "Cold Coffee",
    price: 150,
    servedType: "Cold",
    status: "Available",
  ),
  FoodItem(
    name: "Fresh Lime Soda",
    price: 90,
    servedType: "Cold",
    status: "Pre-Order",
  ),
  FoodItem(
    name: "Ice Cream",
    price: 110,
    servedType: "Cold",
    status: "Available",
  ),
  FoodItem(
    name: "Falooda",
    price: 140,
    servedType: "Cold",
    status: "Available",
  ),
  FoodItem(
    name: "Soft Drink",
    price: 60,
    servedType: "Cold",
    status: "Available",
  ),
];

/// ----------------------
/// DASHBOARD SCREEN
/// ----------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  int countStatus(String status) {
    return foods.where((food) => food.status == status).length;
  }

  @override
  Widget build(BuildContext context) {
    int total = foods.length;
    int available = countStatus("Available");
    int unavailable = countStatus("Unavailable");
    int preorder = countStatus("Pre-Order");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: const Color.fromARGB(255, 247, 122, 84),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            buildCard("Total Items", total.toString(), Colors.blue),
            buildCard("Available", available.toString(), Colors.green),
            buildCard("Unavailable", unavailable.toString(), Colors.red),
            buildCard(
              "Pre-Order",
              preorder.toString(),
              const Color.fromARGB(255, 0, 255, 136),
            ),

            const SizedBox(height: 50),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 30,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FoodMenuScreen(),
                  ),
                );
              },
              child: const Text("Go To Menu"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, String value, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}

/// ----------------------
/// FOOD MENU SCREEN
/// ----------------------
class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  void updateStatus(int index) {
    setState(() {
      if (foods[index].status == "Available") {
        foods[index].status = "Unavailable";
      } else if (foods[index].status == "Unavailable") {
        foods[index].status = "Pre-Order";
      } else {
        foods[index].status = "Available";
      }
    });
  }

  Color getStatusColor(String status) {
    if (status == "Available") return Colors.green;
    if (status == "Unavailable") return Colors.red;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Menu"),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(food.name),
              subtitle: Text("₹${food.price} • ${food.servedType}"),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    food.status,
                    style: TextStyle(
                      color: getStatusColor(food.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => updateStatus(index),
                    child: const Text("Change"),
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
