import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GenericPage extends StatefulWidget {
  late final Text name;
  late final Icon icon;
  late final Color selectedColor;
  GenericPage({super.key});

  @override
  State<GenericPage> createState() => _GenericPageState();
}

class _GenericPageState extends State<GenericPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}