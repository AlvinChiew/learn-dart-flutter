import 'package:app/screens/item_list_screen.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Grocery List', theme: themeData, home: const ItemListScreen());
  }
}
