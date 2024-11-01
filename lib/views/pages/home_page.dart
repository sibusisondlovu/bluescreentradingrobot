import 'package:flutter/material.dart';

import '../../config/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> robots = [{"name": "Robot"},{"name": "Robot"},{"name": "Robot"}]; // List to store robots

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.mainColor,
              AppTheme.ascentColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            Image.asset(
              'assets/images/app-logo.png',
              width: 150,
              height: 150,
            ),
            const Center(
              child: Text(
                'Your are using Robot 1',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0), // Add margin
            padding: const EdgeInsets.all(16.0), // Add padding
            decoration: BoxDecoration(
              color: Colors.white, // White background
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionItem(Icons.play_arrow, 'Start'),
                _buildActionItem(Icons.currency_exchange, 'Symbols'),
                _buildActionItem(Icons.delete, 'Delete'),
              ],
            ),
          ),
            const SizedBox(height: 30),
            Expanded( // Wrap with Expanded for ListView
              child: ListView.builder(
                itemCount:3, //robots.isEmpty ? 1 : robots.length + 1,
                itemBuilder: (context, index) {
                  if (robots.isEmpty || index == robots.length) {
                    // Show "Add Robot" tile
                    return _buildAddRobotTile();
                  } else {
                    // Show robot tile with Start, Symbols, and Delete
                    return _buildRobotTile(robots[index]);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildAddRobotTile() {
    return Card(
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset("assets/images/robot.png"),
        title: const Text(
          "Add Robot",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  Widget _buildRobotTile(Map<String, dynamic> robot) {
    return Card(
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset("assets/images/robot.png"),
        title: Text(
          robot['name'] ?? 'Robot Name', // Display robot name or default
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildActionItem(Icons.play_arrow, 'Start'),
            _buildActionItem(Icons.currency_exchange, 'Symbols'),
            _buildActionItem(Icons.delete, 'Delete'),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String text) {
    return InkWell(
      onTap: () {
        // Handle action (Start, Symbols, Delete)
        // You can add your logic here based on the action
      },
      child: Column(
        children: [
          Icon(icon),
          Text(text),
        ],
      ),
    );
  }
}