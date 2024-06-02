import 'package:flutter/material.dart';
import 'package:palavra_caca/screens/home_screen.dart';

void main() {
  runApp(PalavraCacaApp());
}

class PalavraCacaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caça Palavras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
