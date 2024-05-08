import 'package:app/screens/place_list_screen.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await dotenv.load();
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Places',
      theme: theme,
      home: const Padding(
        padding: EdgeInsets.all(8),
        child: PlaceListScreen(),
      ),
    );
  }
}
