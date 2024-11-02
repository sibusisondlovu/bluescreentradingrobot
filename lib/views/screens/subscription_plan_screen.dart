import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bluescreenrobot/views/widgets/buttons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


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
  bool _isLoading = true;
  Map<String, dynamic>? _planData;

  @override
  void initState() {
    super.initState();
    _fetchPlanDetails();
  }

  Future<void> _fetchPlanDetails() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('memberships')
          .doc('P5OTUMsc2r9wwfT9nTJv') // Plan ID
          .get();
      if (doc.exists) {
        setState(() {
          _planData = doc.data();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching plan details: $e");
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitCircle(
              color: AppTheme.mainColor,
              size: 50.0,
            ),
            SizedBox(height: 20,),
            Text("PLease wait...")
          ],
        ),
      )
          : SingleChildScrollView(
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
          Center(
            child: Text(
              _planData?['name'] ?? 'Standard Plan',
              style: const TextStyle(
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
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _planData?['description'] ?? '',
              style: TextStyle(fontSize: 13, color: Colors.grey[800]),
            ),
            const SizedBox(height: 10),
            Column(
              children: _planData?['features']?.map<Widget>((feature) {
                return FeatureItem(text: feature);
              }).toList() ??
                  [],
            ),
            const SizedBox(height: 10),
            _buildPaymentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSection() {
    final price = _planData?['price'] ?? 0;
    final type = _planData?['type'] ?? '';

    return Center(
      child: Column(
        children: [
          Text(
            "R$price ${type == 'Once Off' ? '' : '/month'}",
            style: const TextStyle(
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
            onPressed: () async {

              setState(() {
                _isLoading = true;
              });

              await Future.delayed(const Duration(seconds: 10));

              final paymentLink = Uri(
                scheme: 'https',
                host: 'payment.payfast.io',
                path: 'eng/process',
                queryParameters: {
                  'cmd': '_paynow',
                  'receiver': '14362369',
                  'return_url': 'https://www.jaspay.co.za/success',
                  'cancel_url': 'https://www.jaspay.co.za/cancel',
                  'notify_url': 'https://www.jaspay.co.za/notify',
                  'amount': price.toString(),
                  'item_name': 'Standard Plan',
                  'item_description': 'Standard Plan Licence',
                },
              );

              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                title: 'Payment Successful',
                desc: 'Your license has been emailed to you. Please copy and paste it on the next screen.',
                btnOkOnPress: () {
                  Navigator.pushNamed(context, 'licenceActivationScreen');
                },
              ).show();

            },
            text: 'PAY NOW',
          ),
        ],
      ),
    );
  }
}
