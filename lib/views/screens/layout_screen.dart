import 'package:bluescreenrobot/views/pages/account_page.dart';
import 'package:bluescreenrobot/views/pages/help_page.dart';
import 'package:bluescreenrobot/views/pages/home_page.dart';
import 'package:bluescreenrobot/views/pages/metatrader_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/theme.dart';
import '../../controllers/main_layout_notifier.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});
  static const String id = "layoutScreen";

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const MetatraderPage(),
    const HelpPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainLayoutNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          body: IndexedStack(
            index: mainScreenNotifier.pageIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Metatrader',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Help',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
            currentIndex: mainScreenNotifier.pageIndex,
            selectedItemColor: AppTheme.mainColor,
            unselectedItemColor: Colors.grey,
            onTap: (value){
              mainScreenNotifier.pageIndex = value;
            },
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}
