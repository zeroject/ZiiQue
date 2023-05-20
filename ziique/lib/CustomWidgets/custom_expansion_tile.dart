import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ziique/BeatBoard/beat_board_widget.dart';
import 'package:ziique/FireService/fire_beat_service.dart';
import 'package:ziique/sound_engine.dart';

import '../FireService/RealtimeData/fire_beatIt_realtime_service.dart';
import '../models/beat.dart';

class CustomExpansionPanel extends StatefulWidget {
  const CustomExpansionPanel(
      {super.key,
      required this.beatId,
      required this.beatTitle,
      required this.beatDescription,
      required this.fontSize,
      required this.tileColor,
      required this.tileRadius,
      required this.soundEngine,
      required this.beat});

  final String beatId;
  final String beatTitle;
  final String beatDescription;
  final double fontSize;
  final Color tileColor;
  final double tileRadius;
  final Beat beat;
  final SoundEngine soundEngine;

  @override
  State<CustomExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          textColor: const Color.fromARGB(255, 0, 0, 0),
          backgroundColor: widget.tileColor,
          collapsedBackgroundColor: widget.tileColor,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.tileRadius))),
          collapsedShape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.tileRadius))),
          leading: Text(widget.beatId),
          title: Text(widget.beatTitle,
              style: TextStyle(fontSize: widget.fontSize)),
          children: [
            ListTile(title: Text(widget.beatDescription)),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    widget.soundEngine.beatString = widget.beat.beatString;
                  },
                  child: Text("Load Beat", style: TextStyle(),
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Update Beat"),
                              content: SizedBox(
                                height: 150,
                                width: 300,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    TextFormField(
                                      initialValue: widget.beat.title,
                                      controller: titleController,
                                      decoration: const InputDecoration(hintText: "Title"),
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      initialValue: widget.beat.description,
                                      controller: descriptionController,
                                      decoration: const InputDecoration(hintText: "Description"),
                                      maxLines: 3,
                                    ),
                                    ],
                                  ),
                              ),
                            actions: [
                              TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                }, 
                                child: const Text("Cancel")),
                              TextButton(
                                onPressed: (){
                                  if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                                    BeatService().updateBeat(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      Beat(
                                          id: widget.beat.id,
                                          title: titleController.text,
                                          by: widget.beat.by,
                                          beatString: widget.soundEngine.beatString,
                                          description: descriptionController.text));
                                    Navigator.pop(context);
                                  }
                                }, 
                                child: const Text("Save")),
                                ],
                      ));
                    },
                    child: const Text("Update Beat")),
                OutlinedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("WARNING", style: TextStyle(
                                  color: Color.fromARGB(255, 255, 60, 60)
                                ),),
                                content: const Text(
                                    "You are about to delete one of your beats. Are you sure this is what you wanted?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        BeatService().deleteBeat(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            widget.beat.id);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Yes"))
                                ],
                              ));
                    },
                    child: const Text("Delete Beat")),
                OutlinedButton(
                  onPressed: () {
                    FireBeatItRealtimeService().createSession(
                        widget.beat, FirebaseAuth.instance.currentUser!.uid);
                  },
                  child: Text(
                    "Start Session",
                    style: TextStyle(),
                  ),
                ),
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
