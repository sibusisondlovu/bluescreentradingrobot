import 'dart:async';

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
  String _selectedRobot = "Select Robot or Add";
  String _selectedRobotId = '';
  bool _isStarted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
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
                    'Blue Screen EA,',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    _selectedRobot,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (_selectedRobot != "Select Robot or Add")
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isStarted = !_isStarted;
                              });

                              if (_isStarted) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.bottomSlide,
                                  title: 'Automated Trading Scheduled',
                                  desc: 'Automated trading has been scheduled. with  $_selectedRobot',
                                  btnOkOnPress: () {
                                    Timer(const Duration(seconds: 5), () {
                                      Navigator.pushNamed(
                                          context, 'automatedTradingScreen');
                                    });
                                  },
                                ).show();
                              }
                            },
                            child: Column(
                              children: [
                                Icon(
                                  _isStarted ? Icons.stop : Icons.play_arrow,
                                  color: _isStarted ? Colors.red : Colors.green,
                                ),
                                const SizedBox(height: 8),
                                Text(_isStarted ? 'Stop' : 'Start'),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'symbolsScreen',
                                  arguments: _selectedRobot);
                            },
                            child: const Column(
                              children: [
                                Icon(Icons.candlestick_chart,
                                    color: Colors.blue),
                                SizedBox(height: 8),
                                Text('Symbols'),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.bottomSlide,
                                title: 'Confirm Delete \n$_selectedRobot',
                                desc:
                                    'Are you sure you want to delete this robot?',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('memberships')
                                        .doc(_selectedRobotId)
                                        .delete();
                                  } catch (e) {
                                    print('Error deleting item: $e');
                                    // Handle error appropriately, e.g., show an error dialog
                                  } finally {}
                                },
                              ).show();
                            },
                            child: const Column(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                SizedBox(height: 8),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container()
              ],
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('memberships')
                .where('emailAddress', isEqualTo: 'demo@kairos.co.za')
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
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 10),
                    child: Text(
                      style: TextStyle(fontSize: 13),
                      'No memberships found for this email address.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final membershipData =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  final ownerName = membershipData['mentorId'] as String?;
                  final valid = membershipData['activeUntil'] as String?;
                  final robotName = membershipData['robotName'] as String?;
                  final emailAddress =
                      membershipData['emailAddress'] as String?;
                  final contactNumber =
                      membershipData['contactNumber'] as String?;
                  final status = membershipData['status'] as String?;
                  final robotId = membershipData['robotId'] as String?;
                  return Card(
                    color: const Color(0xFF001F3F),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/app-logo.png',
                      ),
                      title: Text(
                        robotName!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Owner: $ownerName, \nValid: $valid',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          AwesomeDialog(
                            btnOkText: "Select Robot",
                            dismissOnBackKeyPress: true,
                            dismissOnTouchOutside: true,
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'Robot Info',
                            desc:
                                'Name: $robotName\nOwner: $ownerName\nEmail: $emailAddress\nContact Number: $contactNumber\nValid: $valid',
                            btnOkOnPress: () {
                              setState(() {
                                _selectedRobot = robotName;
                                _selectedRobotId = robotId!;
                              });
                            },
                          ).show();
                        },
                        child: const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        CustomElevatedButton(
            text: 'Add New Robot',
            onPressed: () async {
              Navigator.pushNamed(context, 'licenceActivationScreen');
            })
      ],
    ); // Closing bracket added here
  }
}
