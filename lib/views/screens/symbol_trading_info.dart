import 'package:bluescreenrobot/views/widgets/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../config/theme.dart';

class SelectedSymbolScreen extends StatefulWidget {
  const SelectedSymbolScreen({super.key, required this.symbol});
  final String symbol;
  static const String id = 'selectedSymbolScreen';

  @override
  State<SelectedSymbolScreen> createState() => _SelectedSymbolScreenState();
}

class _SelectedSymbolScreenState extends State<SelectedSymbolScreen> {
  String? _selectedPlatform;
  String? _selectedAction;
  final _lotSizeController = TextEditingController();
  final _numberOfTradesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppTheme.mainColor,
        title: Text('Symbols for ${widget.symbol}', style: TextStyle(fontSize: 13),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _lotSizeController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Lot Size',
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedPlatform,
              onChanged: (value) {
                setState(() {
                  _selectedPlatform = value;
                });
              },
              items: const [
                DropdownMenuItem(value: 'MT4', child: Text('MT4')),
                DropdownMenuItem(value: 'MT5', child: Text('MT5')),
              ],
              decoration: const InputDecoration(
                labelText: 'Select Platform',
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedAction,
              onChanged: (value) {
                setState(() {
                  _selectedAction = value;
                });
              },
              items: const [
                DropdownMenuItem(value: 'SELL', child: Text('SELL')),
                DropdownMenuItem(value: 'BUY', child: Text('BUY')),
                DropdownMenuItem(value: 'BOTH', child: Text('BOTH')),
              ],
              decoration: const InputDecoration(
                labelText: 'Select Action',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _numberOfTradesController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Number of Trades',
              ),
            ),
            const SizedBox(height: 32.0),
            CustomElevatedButton(
              onPressed: () async {
                try {
                  // Show loading spinner
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: SpinKitFadingCircle(color: Colors.blue),
                    ),
                  );

                  final symbolData = {
                    'userUid': 'demoUser',
                    'symbol': widget.symbol,
                    'action': _selectedAction,
                    'platform': _selectedPlatform,
                    'lotSize' : _lotSizeController.text,
                    'numberOfTrades' : _numberOfTradesController.text.trim()
                  };

                  await FirebaseFirestore.instance
                      .collection('automations')
                      .add(symbolData);

                  // Hide loading spinner
                  Navigator.of(context, rootNavigator: true).pop();

                  // Show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Symbol added successfully')),
                  );
                  // Hide loading spinner
                  Navigator.of(context, rootNavigator: true).pop();
                } catch (e) {
                  print('Error adding symbol: $e');
                  // Handle error appropriately, e.g., show an error dialog
                }
              },
              text: 'Save',
            ),
          ],
        ),
      ),
    );
  }
}