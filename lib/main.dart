import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          child: CardInputScreen(
            numberSeparatorLength: 4,
            numberValueLength: 16,
            boxCount: 4,
            widthBox: 60,
            heightBox: 60,
          ),
        ),
      ),
    );
  }
}

class CardInputScreen extends StatefulWidget {
  final int numberSeparatorLength;
  final int numberValueLength;
  final int boxCount;
  final double widthBox;
  final double heightBox;

  const CardInputScreen({
    super.key,
    required this.numberSeparatorLength,
    required this.numberValueLength,
    required this.boxCount,
    required this.widthBox,
    required this.heightBox,
  });

  @override
  _CardInputScreenState createState() => _CardInputScreenState();
}

class _CardInputScreenState extends State<CardInputScreen> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.boxCount, (index) => TextEditingController());
    _focusNodes = List.generate(widget.boxCount, (index) => FocusNode());

    for (var controller in _controllers) {
      controller.addListener(() {
        final text = controller.text;
        if (text.length > widget.numberSeparatorLength) {
          _handlePaste(text);
        }
      });
    }
  }

  void _handlePaste(String text) {
    String cardNumber = text.replaceAll(RegExp(r'\D'), '');
    if (cardNumber.length != widget.numberValueLength) return;

    setState(() {
      for (int i = 0; i < widget.boxCount; i++) {
        _controllers[i].text = cardNumber.substring(
            i * widget.numberSeparatorLength, (i + 1) * widget.numberSeparatorLength);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(widget.boxCount, (index) {
        return SizedBox(
        width: 50,
          height: 50,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            maxLength: widget.numberSeparatorLength,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              counterText: "",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.length == widget.numberSeparatorLength ) {

                if(_controllers[index].text.length == widget.numberValueLength){
                  _focusNodes.last.requestFocus();
                }else{
                  _focusNodes[index + 1].requestFocus();
                }
              }else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CardNumberFormatter(
                index: index,
                controllers: _controllers,
                focusNodes: _focusNodes,
                separatorLength: widget.numberSeparatorLength,
                valueLength: widget.numberValueLength,
                boxCount: widget.boxCount,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  final int index;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final int separatorLength;
  final int valueLength;
  final int boxCount;


  CardNumberFormatter({
    required this.index,
    required this.controllers,
    required this.focusNodes,
    required this.separatorLength,
    required this.valueLength,
    required this.boxCount,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    if (text.length > separatorLength) {
      String cardNumber = text.replaceAll(RegExp(r'\D'), '');
      if (cardNumber.length == valueLength) {
        for (int i = 0; i < boxCount; i++) {
          controllers[i].text = cardNumber.substring(
              i * separatorLength, (i + 1) * separatorLength);
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          focusNodes.last.requestFocus();
        });      }
    }
    return newValue;
  }
}
