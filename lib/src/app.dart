import 'package:flutter/material.dart';

import 'screens/edit_bill/edit_bill_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/view_bill/view_bill_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splitsi - Bill Splitting App',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == HomeScreen.routeName) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const HomeScreen(),
          );
        }

        if (settings.name == EditBillScreen.routeName) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const EditBillScreen(),
          );
        }

        // Handle '/bills/:code'
        final uri = Uri.parse(settings.name ?? '');
        final path = ViewBillScreen.routeName.replaceFirst(RegExp(r'/'), '');
        if (uri.pathSegments.first == path && uri.pathSegments.length == 2) {
          final code = uri.pathSegments[1];
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => ViewBillScreen(code: code),
          );
        }

        return null;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Text('${settings.name} not found'),
              ),
            );
          },
        );
      },
    );
  }
}
