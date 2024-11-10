import 'package:bluescreenrobot/config/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SymbolsScreen extends StatefulWidget {
  const SymbolsScreen({super.key, required this.robotName});
  static const String id = "symbolsScreen";
  final String robotName;

  @override
  State<SymbolsScreen> createState() => _SymbolsScreenState();
}

class _SymbolsScreenState extends State<SymbolsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppTheme.mainColor,
          title: Text('Symbols for ${widget.robotName}', style: TextStyle(fontSize: 13),),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            dividerColor: AppTheme.ascentColor,
            tabs: [
              Tab(text: 'Allowed Symbols'),
              Tab(text: 'All Symbols'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
          allowedSymbols(),  // Page for Allowed Symbols tab
            allSymbols()// Page for All Symbols tab
          ],
        ),
      ),
    );
  }

  Widget allSymbols() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('symbols').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No symbols loaded yet.'),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final symbolData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            final symbol = symbolData['symbol'] as String; // Assuming 'symbol' is a String field

            return Card(
              child: ListTile(
                onTap: (){
                  _addSymbolToUser(context, symbol);
                },
                title: Text(symbol),
                trailing: const Icon(Icons.add),
              ),
            );
          },
        );
      },
    );
  }

  Widget allowedSymbols(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('automations')
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
            child: Text('No allowed symbols found.'),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final symbolData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            final symbol = symbolData['symbol'] as String?;
            final lot = symbolData['lotSize'] as String?;
            final action = symbolData['action'] as String?;
            final trades = symbolData['numberOfTrades'] as String?;
            final platform = symbolData['platform'] as String?;

            return Card(
              child: ListTile(
                title: Text('$symbol - $platform', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                subtitle: Text('Lot: $lot - Action: $action - Trades: $trades',style: TextStyle(fontSize: 11),),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {

                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
  Future<void> _addSymbolToUser(BuildContext context, String symbol) async {

    Navigator.pushNamed(context, 'selectedSymbolScreen', arguments: symbol);

  }
}
