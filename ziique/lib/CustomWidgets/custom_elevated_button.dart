import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget{
  const CustomElevatedButton({super.key, required this.abc, required this.i, required this.function, required this.isPressed});
  final List<String> abc;
  final int i;
  final Function function;
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: (i % 16 == 0) ? Colors.green : (i & 16 == 0) ? (isPressed == false) ? Colors.grey : Colors.black : Colors.blueGrey
      ),
      onPressed: () {
        function();
      },
      child: Text(
        (i % 16 == 0) ? abc[i == 1 ? 1 : i~/16] : i.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}