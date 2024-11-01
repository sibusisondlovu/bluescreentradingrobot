import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../widgets/faq_item_widget.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final List<Map<String, String>> faqData = [
    {
      "question": "How do I activate my license?",
      "answer":
      "To activate your license, enter the license key from your activation email and click the 'Activate' button."
    },
    {
      "question": "What is KariosFX?",
      "answer":
      "KariosFX is the official mentor for trading strategies that can be integrated with this app."
    },
    {
      "question": "How do I reset my password?",
      "answer":
      "To reset your password, go to the login screen and select 'Forgot Password'. Follow the instructions to reset."
    },
    {
      "question": "Can I change my subscription plan?",
      "answer":
      "Yes, you can change your subscription plan in the settings under 'Subscription Management'."
    },
    {
      "question": "Is my account information secure?",
      "answer":
      "Yes, we prioritize security and use encryption to protect all account data and transaction details."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
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
      ),
      Container(
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
                'Help',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            Expanded( // Wrap ListView.builder with Expanded
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    shrinkWrap: true, // Set shrinkWrap to true
                    itemCount: faqData.length,
                    itemBuilder: (context, index) {
                      return FAQItem(
                        question: faqData[index]["question"]!,
                        answer: faqData[index]["answer"]!,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}