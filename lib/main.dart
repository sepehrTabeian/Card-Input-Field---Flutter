import 'package:card_input_field/card_input_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: CardInputScreen(numberSeparatorLength: 1, numberValueLength: 4, boxCount: 4, widthBox: 60, heightBox: 60),
        ),
      ),
    );
  }
}

