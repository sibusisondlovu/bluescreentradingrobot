import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../config/theme.dart';
import '../widgets/buttons.dart';

class LicenceActivationScreen extends StatefulWidget {
  const LicenceActivationScreen({super.key});
  static const String id  = "licenceActivationScreen";

  @override
  State<LicenceActivationScreen> createState() => _LicenceActivationScreenState();
}

class _LicenceActivationScreenState extends State<LicenceActivationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _licenceKeyController = TextEditingController();
  bool isLoading = false;
  String? _selectedMentor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_isLoading
          ? Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4, // 40% of screen height
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
              // Add any child widgets you want inside the container
            ),

            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              child: ListView(
                children: [
                  Image.asset('assets/images/app-logo.png', width: 150, height: 150,),
                  const Center(
                    child: Text('Activate', style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white
                    ),),
                  ),
                  const SizedBox(height: 30,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Instruction Text
                            Text(
                              "Please enter your license key from the activation email.",
                              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                            ),
                            const SizedBox(height: 20),

                            // License Key Field
                            TextFormField(
                              controller: _licenceKeyController,
                              decoration: const InputDecoration(
                                labelText: "License Key",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your license key.";
                                }
                                return null;
                              },

                            ),
                            const SizedBox(height: 20),

                            // Dropdown for Mentor Selection
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: "Select Mentor",
                                border: OutlineInputBorder(),
                              ),
                              value: _selectedMentor,
                              hint: const Text("Select Mentor"),
                              items: const [
                                DropdownMenuItem(
                                  value: "Kairos FX",
                                  child: Text("Kairos FX"),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedMentor = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Please select a mentor.";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),

                            CustomElevatedButton(
                              onPressed: (){
                                _checkLicenceKey();

                              },
                              text: 'ACTIVATE',
                            ),
                          ],
                        ),
                      ),
                  ),
                  )],
              ),
            ),
          ])
          : const Center(
        child: SpinKitCircle(
          color: AppTheme.mainColor,
          size: 50.0,
        ),
      ),
    );
  }

  Future<void> _checkLicenceKey() async {
    setState(() {
      isLoading = true;
    });

    final licenceKey = _licenceKeyController.text.trim();

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('licences')
          .where('licenceKy', isEqualTo: licenceKey)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final licenceData = querySnapshot.docs.first.data();

        // Show Awesome Dialog with license details
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          title: 'License Details Found',
          desc: 'Email: ${licenceData['emailAddress']}\n'
              'Mentor: ${licenceData['mentor']}\n'
              'Purchase Date: ${licenceData['purchaseDate']}\n'
              'Expiry Date: ${licenceData['expiryDate']}',
          btnOkOnPress: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              'layoutScreen',
                  (Route<dynamic> route) => false,
            );
          },
        ).show();
      } else {
        // Show error message if license key is not found
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'License Key Not Found',
          desc: 'Please enter a valid license key.',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking license key: $e');
      }
      // Handle error appropriately, e.g., show an error dialog
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
