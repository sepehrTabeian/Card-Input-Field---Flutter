import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'card_number_formatter.dart';
import 'card_input_controller.dart';

class CardInputComponent extends StatelessWidget {
  final int index;
  final CardInputController controller;
  final VoidCallback onUpdate;
  final double widthBox;
  final double heightBox;


  const CardInputComponent({
    super.key,
    required this.index,
    required this.controller,
    required this.onUpdate,
    required this.widthBox,
    required this.heightBox,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthBox,
      height: heightBox,
      child: TextField(
        controller: controller.controllers[index],
        style: const TextStyle(height: 1),
        focusNode: controller.focusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: controller.numberSeparatorLength,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          counterText: "",
          border: OutlineInputBorder(),
        ),
        onChanged: (value) => controller.handleTextChange(index, value, onUpdate),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CardNumberFormatter(
            index: index,
            controllers: controller.controllers,
            focusNodes: controller.focusNodes,
            separatorLength: controller.numberSeparatorLength,
            valueLength: controller.numberValueLength,
            boxCount: controller.boxCount,
          ),
        ],
      ),
    );
  }
}
