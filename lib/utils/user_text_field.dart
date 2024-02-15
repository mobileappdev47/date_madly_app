import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  final titleLabel;
  final maxLength;
  final icon;
  final controller;
  final inputType;

  const UserTextField(
      {super.key, @required this.titleLabel,
      @required this.maxLength,
      @required this.icon,
      @required this.controller,
      @required this.inputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextField(
        maxLength: maxLength,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          filled: true,
          labelText: titleLabel,
          suffixIcon: Icon(icon),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }
}
