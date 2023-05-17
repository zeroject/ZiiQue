import 'package:flutter/material.dart';


class CustomExpansionTileFriends extends StatefulWidget{

  const CustomExpansionTileFriends({
    super.key, 
    required this.friendName,
    required this.description,
    required this.fontSize,
    required this.tileColor,
    required this.tileRadius
  });

  final String friendName;
  final String description;
  final double fontSize;
  final Color tileColor;
  final double tileRadius;

  @override
  State<CustomExpansionTileFriends> createState() => _CustomExpansionTileFriendsState();
}

class _CustomExpansionTileFriendsState extends State<CustomExpansionTileFriends> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          textColor: const Color.fromARGB(255, 0, 0, 0),
          backgroundColor: widget.tileColor,
          collapsedBackgroundColor: widget.tileColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.tileRadius))
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.tileRadius))
          ),
          title: Text(
            widget.friendName,
            style: TextStyle(fontSize: widget.fontSize)),
          children: [
            ListTile(
              title: Text(widget.description)
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(onPressed: (){}, child: const Text("Remove Friend"))
              ],
            )
          ],
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}