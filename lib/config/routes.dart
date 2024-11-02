import 'package:bluescreenrobot/views/screens/payfast_screen.dart';
import 'package:bluescreenrobot/views/screens/subscription_plan_screen.dart';
import 'package:flutter/material.dart';
import '../views/screens/layout_screen.dart';
import '../views/screens/licence_activation_screen.dart';
import '../views/screens/subscribe.dart';
import '../views/screens/symbols_screen.dart';
import '../wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    switch (settings.name) {

      case Wrapper.id:
        return _route(const Wrapper());

      case SubscribeScreen.id:
        return _route(const SubscribeScreen());

      case SubscriptionPlanScreen.id:
        return _route(const SubscriptionPlanScreen());

      case LicenceActivationScreen.id:
        return _route(const LicenceActivationScreen());

      case LayoutScreen.id:
        return _route(const LayoutScreen());

      case SymbolsScreen.id:
        return _route(const SymbolsScreen());

      // case PayfastScreen.id:
      //   return _route(PayfastScreen(uri: args));

      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _route(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);

  static Route<dynamic> _errorRoute(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            )
          ],
        ),
        body: Center(
          child: Text(
            'ROUTE \n\n$name\n\nNOT FOUND',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}