import 'package:flutter/material.dart';
import 'package:ziique/Custom%20Widgets/customElevatedButton.dart';

class ImBeatBoard extends StatelessWidget {
  const ImBeatBoard({super.key, required this.numberOfRows, required this.abc, required this.child});

  final int numberOfRows;
  final List<String> abc;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(
      padding: const EdgeInsets.all(8),
      crossAxisCount: 16,
      children: [
        for (var i = 0; i < 16 * numberOfRows; i++)
          Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: child
            ),
          ),
      ],
    );
  }
}
