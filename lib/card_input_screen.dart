import 'package:card_input_field/card_input_component.dart';
import 'package:flutter/material.dart';
import 'card_input_controller.dart';

class CardInputScreen extends StatefulWidget {
  final int numberSeparatorLength;
  final int numberValueLength;
  final int boxCount;
  final double widthBox;
  final double heightBox;

  const CardInputScreen({
    Key? key,
    required this.numberSeparatorLength,
    required this.numberValueLength,
    required this.boxCount,
    required this.widthBox,
    required this.heightBox,
  }) : super(key: key);

  @override
  _CardInputScreenState createState() => _CardInputScreenState();
}

class _CardInputScreenState extends State<CardInputScreen> {
  late final CardInputController _cardInputController;

  @override
  void initState() {
    super.initState();
    _cardInputController = CardInputController(
      boxCount: widget.boxCount,
      numberSeparatorLength: widget.numberSeparatorLength,
      numberValueLength: widget.numberValueLength,
    );
  }

  @override
  void dispose() {
    _cardInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        widget.boxCount,
            (index) => CardInputComponent(
          index: index,
          controller: _cardInputController,
          onUpdate: () => setState(() {}), // Update UI without Provider
        ),
      ),
    );
  }
}
