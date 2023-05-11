import 'package:flutter/material.dart';

class CustomElevatedButton extends ElevatedButton{
  const CustomElevatedButton({super.key, required super.onPressed, required super.child});
  final bool isPressed = false;
}