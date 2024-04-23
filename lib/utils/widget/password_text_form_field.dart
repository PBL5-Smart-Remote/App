import 'dart:core';

import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  bool obscureText = true;
  String obscuringCharacter = '•';
  String? initialValue;
  TextEditingController? controller;
  String? Function(String?)? validator;
  AutovalidateMode? autovalidateMode;
  TextStyle? style;
  TextDirection? textDirection;
  TextAlign textAlign;
  bool readOnly;
  bool expands;
  int? maxLength;
  Text label;
  InputDecoration decoration = const InputDecoration();

  PasswordFormField({
    super.key, 
    this.initialValue,
    this.controller, 
    this.validator, 
    this.autovalidateMode,
    this.style,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.maxLength,
    this.expands = false,
    this.label = const Text(''),
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  @override
  Widget build(BuildContext context) {
    IconButton showhide = IconButton(
      icon: Icon(widget.obscureText ? Icons.visibility_off : Icons.visibility),
      onPressed: () {
        setState(() {
          widget.obscureText = !widget.obscureText;
        });
      }
    );
    widget.decoration = InputDecoration(
      label: widget.label,
      suffixIcon: showhide
    );

    return TextFormField(
      initialValue: widget.initialValue,
      obscureText: widget.obscureText,
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      style: widget.style,
      decoration: widget.decoration,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      readOnly: widget.readOnly,
      maxLength: widget.maxLength,
      expands: widget.expands,
    );
  }
}