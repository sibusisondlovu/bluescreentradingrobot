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
  String? _licenseKey;
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
                              onSaved: (value) {
                                _licenseKey = value;
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
                                  value: "KariosFX",
                                  child: Text("KariosFX"),
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
                                Navigator.pushNamed(context, 'layoutScreen');

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
}
