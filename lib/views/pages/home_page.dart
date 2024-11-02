import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bluescreenrobot/views/widgets/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../config/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> robots = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
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
          child: Container(
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
                    'Good day Connie,',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'UserId: KFX-123-CON',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ), // Closing parenthesis added here
              ],
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc("eYVA7cUagdQSqgCj21je9MyeNYV2")
              .collection('robots')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'You don\'t have any robots yet. Add one using the button below.',
                  textAlign: TextAlign.center,
                ),
              );
            }

            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final robotData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return _buildRobotTile(robotData);
                },
              ),
            );
          },
        ),
        CustomElevatedButton(text: 'Add New Robot', onPressed: () async {

            await AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            title: 'Adding Your Robot',
            desc: 'You are adding a robot. Please authenticate to proceed.',
            btnOkText: 'Authenticate',
            btnOkOnPress: () {
              // Close the dialog
              Navigator.of(context).pop();

              // Show loading spinner
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: SpinKitFadingCircle(color: Colors.blue),
                ),
              );

              // Save robot details to Firestore
              _saveRobotDetails();
            },
            ).show();
        })

      ],
    ); // Closing bracket added here
  }

  Future<void> _saveRobotDetails() async {
    try {
      final robotData = {
        'robotName': 'Test Robot',
        'description': 'Test Description',
        'owner': 'Kairos FX',
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc("eYVA7cUagdQSqgCj21je9MyeNYV2")
          .collection('robots')
          .add(robotData);

      // Hide loading spinner and navigate to the next screen
      Navigator.of(context, rootNavigator: true).pop(); // Hide loading spinner
     // _navigateToAddRobotScreen(); // Navigate to add robot screen
    } catch (e) {
      if (kDebugMode) {
        print('Error saving robot details: $e');
      }
      // Handle error appropriately, e.g., show an error dialog
    }
  }
  Widget _buildActionItem(IconData icon, String text) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'symbolsScreen');
      },
      child: Column(
        children: [
          Icon(icon),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildRobotTile(robot) {
    return Card(
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset("assets/images/app-logo.png"),
        title: Text(
          robot['robotName'] + ' - ' + robot['owner'], // Display robot name or default
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              robot['description'] ?? 'Kairos FX', // Display robot name or default
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionItem(Icons.play_arrow, 'Start'),
                _buildActionItem(Icons.currency_exchange, 'Symbols'),
                _buildActionItem(Icons.delete, 'Delete'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
