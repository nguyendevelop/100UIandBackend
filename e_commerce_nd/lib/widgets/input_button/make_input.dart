import 'package:flutter/material.dart';

class MakeInput extends StatelessWidget {
  final TextEditingController controllers;
  final String? labels;
  final bool obscureTexts;
  final TextInputType keyboardTypes;
  final InputDecoration decorations;
  final ValueChanged<String>? onChangeds;

  const MakeInput({
    required this.controllers,
    this.labels,
    this.obscureTexts = false,
    required this.keyboardTypes,
    required this.decorations,
    this.onChangeds,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labels ?? '',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controllers,
          obscureText: obscureTexts,
          onChanged: onChangeds,
          keyboardType: keyboardTypes,
          decoration: decorations,
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
