import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Handles formatting for credit card input fields by managing text updates and focus movement.
class CardNumberFormatter extends TextInputFormatter {
  final int index;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final int separatorLength;
  final int valueLength;
  final int boxCount;
  final VoidCallback? onComplete;

  CardNumberFormatter({
    required this.index,
    required this.controllers,
    required this.focusNodes,
    required this.separatorLength,
    required this.valueLength,
    required this.boxCount,
    this.onComplete,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String cleanText = _sanitizeInput(newValue.text);

    if (cleanText.length == valueLength) {
      _updateTextFields(cleanText);
      _moveFocus();
      onComplete?.call();
    }

    return newValue;
  }

  /// Removes non-digit characters from input.
  String _sanitizeInput(String text) => text.replaceAll(RegExp(r'\D'), '');

  /// Distributes formatted text into separate controllers.
  void _updateTextFields(String cardNumber) {
    for (int i = 0; i < boxCount; i++) {
      final start = i * separatorLength;
      final end = (i + 1) * separatorLength;
      if (start < cardNumber.length) {
        controllers[i].text = cardNumber.substring(start, end.clamp(0, cardNumber.length));
      }
    }
  }

  /// Moves focus to the last field once input is complete.
  void _moveFocus() {
    if (focusNodes.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusNodes.last.requestFocus();
      });
    }
  }
}

