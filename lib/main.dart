import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickynotifs/models/state.dart';
import 'package:stickynotifs/pages/create.dart';
import 'package:stickynotifs/pages/details.dart';
import 'package:stickynotifs/pages/home.dart';
import 'package:stickynotifs/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: NoteModel())],
        child: MaterialApp(
            title: 'StickyNotifs',
            theme: buildDarkTheme(),
            initialRoute: '/',
            routes: {
              '/': (context) => const HomePage(),
              '/details': (context) => const DetailsPage(),
              '/create': (context) => const CreatePage(),
            }));
  }
}
