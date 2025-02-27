import 'package:flutter/material.dart';

class CardInputController {
  final int boxCount;
  final int numberSeparatorLength;
  final int numberValueLength;

  final List<TextEditingController> controllers = [];
  final List<FocusNode> focusNodes = [];

  CardInputController({
    required this.boxCount,
    required this.numberSeparatorLength,
    required this.numberValueLength,
  }) {
    _initControllers();
  }

  void _initControllers() {
    for (int i = 0; i < boxCount; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());

      controllers[i].addListener(() {
        final text = controllers[i].text;
        if (text.length > numberSeparatorLength) {
          handlePaste(text);
        }
      });
    }
  }

  void handlePaste(String text) {
    String cardNumber = text.replaceAll(RegExp(r'\D'), '');
    if (cardNumber.length != numberValueLength) return;

    for (int i = 0; i < boxCount; i++) {
      int start = i * numberSeparatorLength;
      int end = start + numberSeparatorLength;
      if (end <= cardNumber.length) {
        controllers[i].text = cardNumber.substring(start, end);
      }
    }
  }

  void handleTextChange(int index, String value, Function onUpdate) {
    if (value.length == numberSeparatorLength) {
      if (controllers[index].text.length == numberValueLength) {
        focusNodes.last.requestFocus();
      } else if (index < boxCount - 1) {
        focusNodes[index + 1].requestFocus();
      }
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    onUpdate(); // Calls setState() in the UI
  }

  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
  }
}
