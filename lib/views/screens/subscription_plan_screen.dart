import 'package:bluescreenrobot/views/widgets/buttons.dart';
import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../widgets/feature_item.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({super.key});
  static const String id = "subscriptionPlanScreen";

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _buildBackgroundGradient(),
            _buildContent(),
          ],
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
      child: Column(
        children: [
          Image.asset(
            'assets/images/app-logo.png',
            width: 150,
            height: 150,
          ),
          const Center(
            child: Text(
              'Standard Plan',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 30),
          _buildPlanDetailsCard(),
        ],
      ),
    );
  }

  Widget _buildPlanDetailsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "Get access to powerful trading automation and advanced tools to boost your trading success!",
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            const SizedBox(height: 20),
            const Column(
              children: [
                FeatureItem(text: "Automated Trading Execution"),
                FeatureItem(text: "Customizable Trading Strategies"),
                FeatureItem(text: "Real-Time Market Monitoring"),
                FeatureItem(text: "Secure Account Integration"),
                FeatureItem(text: "24/7 Support"),
              ],
            ),
            _buildPaymentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Center(
      child: Column(
        children: [
          const Text(
            "R234.00 per month",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: _termsAccepted,
                onChanged: (value) {
                  setState(() {
                    _termsAccepted = value!;
                  });
                },
              ),
              const Text("Accept Terms and Conditions"),
            ],
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(
            onPressed: _termsAccepted ? _handlePayment : null,
            text: 'PAY NOW',
          ),
        ],
      ),
    );
  }

  void _handlePayment() {
    Navigator.pushNamed(context, 'licenceActivationScreen');
  }
}