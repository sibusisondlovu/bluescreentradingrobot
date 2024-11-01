import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../config/theme.dart';
import '../widgets/buttons.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});
  static const String id = 'subscribeScreen';

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false;

  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

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
                    child: Text('Subscribe', style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white
                    ),),
                  ),
                  const SizedBox(height: 30,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _namesController,
                                decoration: const InputDecoration(
                                  labelText: 'Full Names',
                                  prefixIcon: Icon(Icons.person),
                                  border: UnderlineInputBorder(),
                                ),
                                keyboardType: TextInputType.emailAddress,

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email address';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _contactNumberController,
                                decoration: const InputDecoration(
                                  labelText: 'Contact Number',
                                  prefixIcon: Icon(Icons.phone),
                                  border: UnderlineInputBorder(),
                                ),
                                keyboardType: TextInputType.phone,

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your contact number';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _emailAddressController,
                                decoration: const InputDecoration(
                                  labelText: 'Email Address',
                                  prefixIcon: Icon(Icons.email),
                                  border: UnderlineInputBorder(),
                                ),
                                keyboardType: TextInputType.emailAddress,

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email address';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: _togglePasswordVisibility,
                                  ),
                                  border: const UnderlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomElevatedButton(
                                onPressed:  () {
                                  _register(context);
                                }, text: 'Subscribe',
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'By tapping register you agree to our Terms and Conditions.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 20),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Have an account? ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    TextSpan(
                                      text: 'LOGIN HERE',
                                      style: const TextStyle(
                                          color: AppTheme.mainColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(context, 'loginScreen');
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                ],
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

  Future<void> _register(context) async {
    Navigator.pushNamed(context, 'subscriptionPlanScreen');
  }
}
