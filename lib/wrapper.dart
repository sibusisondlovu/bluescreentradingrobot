import 'package:bluescreenrobot/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({super.key});
  static const String id = 'wrapper';

  @override
  State<Wrapper> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<Wrapper> {

  @override
  void initState() {
    super.initState();
    _checkDrawOverlayPermission();
  }

  Future<void> _checkDrawOverlayPermission() async {
    if (await Permission.systemAlertWindow.isGranted) {
      _navigateToHomeScreen();
    } else {
      _navigateToPermissionSettingsScreen();
    }
  }

  void _navigateToHomeScreen() {
    Navigator.pushReplacementNamed(context, 'layoutScreen');
  }

  void _navigateToPermissionSettingsScreen() {
   Navigator.pushNamed(context, 'welcomeScreen');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCircle(color: Colors.blue),
            SizedBox(height: 16),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }


}