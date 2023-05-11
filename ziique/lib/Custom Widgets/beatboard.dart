import 'package:flutter/material.dart';
import 'package:ziique/Custom%20Widgets/customElevatedButton.dart';
import '../models/beatInfo.dart';

class BeatBoard extends StatefulWidget {
  const BeatBoard(
      {super.key,
      required this.playBarWidth,
      required this.playBarColor,
      required this.playBarRounding,
      required this.playBarButtonSize,
      required this.playBarFontSize,
      required this.playBarOffset,
      required this.beatButtonBackColor,
      required this.beatButtonSize,
      required this.beatButtonSampleColor,
      required this.beatButtonNormColor,
      required this.beatButtonNormPressColor});

  //PlayBar Options
  final double playBarWidth;
  final Color playBarColor;
  final double playBarRounding;
  final double playBarButtonSize;
  final double playBarFontSize;
  final double playBarOffset;

  //BeatBoard Options
  final Color beatButtonBackColor;
  final double beatButtonSize;
  final Color beatButtonSampleColor;
  final Color beatButtonNormColor;
  final Color beatButtonNormPressColor;

  @override
  State<BeatBoard> createState() => _BeatBoardState();
}

class _BeatBoardState extends State<BeatBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Flexible(
                child: SizedBox(
                  width: widget.playBarWidth,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: widget.playBarColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.playBarRounding),
                      ),
                      color: widget.playBarColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: widget.playBarButtonSize,
                            height: widget.playBarButtonSize,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Play",
                                style:
                                    TextStyle(fontSize: widget.playBarFontSize),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: widget.playBarButtonSize * 1.33,
                            height: widget.playBarButtonSize,
                            child: TextFormField(
                                decoration:
                                    const InputDecoration(hintText: "BPM")),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: widget.playBarOffset,
            ),
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: widget.beatButtonBackColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: widget.beatButtonSize,
                      width: widget.beatButtonSize,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("A"),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: widget.beatButtonBackColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: widget.beatButtonSize,
                      width: widget.beatButtonSize,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("B"),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: widget.beatButtonBackColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: widget.beatButtonSize,
                      width: widget.beatButtonSize,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("C"),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: widget.beatButtonBackColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: widget.beatButtonSize,
                      width: widget.beatButtonSize,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("D"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 600,
              width: 1600,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 16),
                children: [
                  for (var i = 0; i < 64; i++)
                    Container(
                      decoration: BoxDecoration(
                          color: widget.beatButtonBackColor
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: widget.beatButtonSize,
                          width: widget.beatButtonSize,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(""),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
