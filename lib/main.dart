import 'package:flutter/material.dart';
import 'package:stickynotifs/pages/home.dart';
import 'package:stickynotifs/theme.dart';
import 'package:stickynotifs/util/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationsService().init();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'StickyNotifs',
        theme: buildDarkTheme(),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
        });
  }
}
