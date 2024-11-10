import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../config/theme.dart';
import '../widgets/buttons.dart';

class MetatraderPage extends StatefulWidget {
  const MetatraderPage({super.key});

  @override
  State<MetatraderPage> createState() => _MetatraderPageState();
}

class _MetatraderPageState extends State<MetatraderPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  int _selectedPlatform = 0;
  String _selected = "MT4";
  String _status = "";

  List<Map<String, dynamic>> _metatraderDataList = [];

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _serverController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchMetatraderData(); // Call the fetch function
  }

  Future<void> _fetchMetatraderData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('metatrader').get();

      _metatraderDataList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      _usernameController.text = _metatraderDataList[0]['mt4_username'];
      _serverController.text = _metatraderDataList[0]['mt4_server'];
      _passwordController.text = _metatraderDataList[0]['mt4_password'];
      _status = _metatraderDataList[0]['mt4_status'];

    } catch (e) {
      if (kDebugMode) {
        print('Error fetching Metatrader data: $e');
      }
      // Handle error appropriately, e.g., show an error dialog
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_isLoading
          ? Stack(
        children: [
          _buildBackgroundGradient(),
          _buildContent(),
        ],
      )
          : const Center(
        child: SpinKitCircle(
          color: AppTheme.mainColor,
          size: 50.0,
        ),
      ),
    );
  }

  Widget _buildBackgroundGradient() {
    return Container(
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
    );
  }

  Widget _buildContent() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: SingleChildScrollView( // Use SingleChildScrollView
        child: Column(
          children: [
            Image.asset(
              'assets/images/app-logo.png',
              width: 150,
              height: 150,
            ),
            const Center(
              child: Text(
                'Meta Trader Login',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),

            _buildLoginForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformSelection() {
    return Column(
      children: [
        const Text(
          "Choose Platform:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          isSelected: [
            _selectedPlatform == 0,
            _selectedPlatform == 1,
          ],
          onPressed: (int index) {
            setState(() {
              _selectedPlatform = index;

              if (index == 0) {
                _selected = "MT4";
                _usernameController.text = _metatraderDataList[0]['mt4_username'];
                _serverController.text = _metatraderDataList[0]['mt4_server'];
                _passwordController.text = _metatraderDataList[0]['mt4_password'];
                _status = _metatraderDataList[0]['mt4_status'];
              }else{
                _selected = "MT5";
                _usernameController.text = _metatraderDataList[0]['mt5_username'];
                _serverController.text = _metatraderDataList[0]['mt5_server'];
                _passwordController.text = _metatraderDataList[0]['mt5_password'];
                _status = _metatraderDataList[0]['mt5_status'];
              }
            });
          },
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "MT4",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "MT5",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              _buildPlatformSelection(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.do_not_disturb_on_total_silence_rounded, color: _status == 'Not Active'? Colors.red: Colors.green),
                    SizedBox(width: 10,),
                    Text(_status, style: TextStyle(color: _status == 'Not Active'? Colors.red: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Login',
                  prefixIcon: Icon(Icons.person),
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your login';
                  }
                  return null;
                },
              ),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _serverController,
                decoration: const InputDecoration(
                  labelText: 'Server',
                  prefixIcon: Icon(Icons.cloud),
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your server';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle login logic here
                  }
                },
                text:  "SAVE $_selected LOGINS",
              ),
            ],
          ),
        ),
      ),
    );
  }
}