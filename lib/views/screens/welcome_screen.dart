import 'package:bluescreenrobot/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const String id = "welcomeScreen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001F3F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/app-logo.png', fit: BoxFit.fill, height: MediaQuery.of(context).size.height * 0.3, width: MediaQuery.of(context).size.width * 0.7,),
            const SizedBox(height: 18),
            const Text(
              'Welcome To Blue Screen EA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Welcome to Blue Screen EA. Please make sure all the buttons are green ticked. If only one of the test have not passed it means you wont be able to do automated trades.\n\nNote that Blue Screen Robot is not a trading robot, its an app which allows a mentor to give access of the Forex Trading Robot to their students',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              onPressed: () {
               // openAppSettings();
                Navigator.pushNamed(context, "layoutScreen");
              },
              text: 'Allow Draw On Top',
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              Text("Permission not enabled", style: TextStyle(color: Colors.white,fontSize: 14),),
              Icon(Icons.cancel, color: Colors.red, size: 25,)
            ],)
          ],
        ),
      ),
    );
  }
}
