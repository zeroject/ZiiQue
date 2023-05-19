import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ziique/FireService/fire_beat_service.dart';

import '../models/beat.dart';


class CustomExpansionPanel extends StatefulWidget{

  const CustomExpansionPanel({
    super.key, 
    required this.beatId,
    required this.beatTitle,
    required this.beatDescription,
    required this.fontSize,
    required this.tileColor,
    required this.tileRadius,
    required this.beat
  });

  final String beatId;
  final String beatTitle;
  final String beatDescription;
  final double fontSize;
  final Color tileColor;
  final double tileRadius;
  final Beat beat;

  @override
  State<CustomExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {
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
          leading: Text(widget.beatId),
          title: Text(
            widget.beatTitle,
            style: TextStyle(fontSize: widget.fontSize)),
          children: [
            ListTile(
              title: Text(widget.beatDescription)
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(onPressed: (){

                }, child: const Text("Edit")),
                OutlinedButton(onPressed: (){
                  BeatService().deleteBeat(FirebaseAuth.instance.currentUser!.uid, widget.beat.id);
                }, child: const Text("Delete"))
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