
import 'package:flutter/material.dart';

import '../../config/theme.dart';

class TradingScreen extends StatefulWidget {
  const TradingScreen({super.key});
  static const String id = "automatedTradingScreen";

  @override
  State<TradingScreen> createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {
  List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _showLogs();
  }

  Future<void> _showLogs() async {
    final logs = [
      '>> opening MT5',
      '#Initialising MT5',
      '>> Accepting disclaimer.',
      '>>logging into MT5 account',
      '>> searching for the symbol',
      '>> pressing the sysmbol',
      '>> searching for the symbol',
      '>> pressing the symbol',
      '>> pressing show button',
      '>> putting trade details.',
      '>> putting trade details.',
      '>> putting trade details',
      ">> trade completed :-)"
      ">> logging off...."
      ">> logging off successfully"
    ];

    for (var i = 0; i < logs.length; i++) {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _logs.add(logs[i]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppTheme.mainColor,
        title: const Text('Blue Screen EA', style: TextStyle(fontSize: 13),),
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top:20, bottom: 15),
            child: Image.asset('assets/images/app-logo.png', width: 60,),
          ),
          const Text(textAlign: TextAlign.center, 'TRADING IN PROGRESS.\n DO NOT USE YOUR PHONE!', style: TextStyle(fontSize: 14, color: Colors.red),),
          Expanded(
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  return Text(
                    _logs[index],
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}