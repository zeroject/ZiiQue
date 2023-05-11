import 'package:flutter/material.dart';

class BeatBoard extends StatelessWidget {
  const BeatBoard(
      {super.key,
      required this.playBarWidth,
      required this.playBarColor,
      required this.playBarRounding,
      required this.playBarButtonSize,
      required this.playBarFontSize,
      required this.playBarOffset,
      required this.numberOfBeatButtons,
      required this.beatButtonBackColor,
      required this.beatButtonSize,
      required this.beatButtonSampleColor,
      required this.beatButtonNormColor,
      required this.childRowA,
      required this.childRowB,
      required this.childRowC,
      required this.childRowD});

  //PlayBar Options
  final double playBarWidth;
  final Color playBarColor;
  final double playBarRounding;
  final double playBarButtonSize;
  final double playBarFontSize;
  final double playBarOffset;

  //BeatBoard Options
  final List<int> numberOfBeatButtons;
  final Color beatButtonBackColor;
  final double beatButtonSize;
  final Color beatButtonSampleColor;
  final Color beatButtonNormColor;
  final Widget childRowA;
  final Widget childRowB;
  final Widget childRowC;
  final Widget childRowD;

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
                  width: playBarWidth,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: playBarColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(playBarRounding),
                      ),
                      color: playBarColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: playBarButtonSize,
                            height: playBarButtonSize,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Play",
                                style: TextStyle(fontSize: playBarFontSize),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: playBarButtonSize * 1.33,
                            height: playBarButtonSize,
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
              width: playBarOffset,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i in numberOfBeatButtons)
              Container(
                decoration: BoxDecoration(
                  color: beatButtonBackColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: beatButtonSize,
                      width: beatButtonSize,
                      child: childRowA),
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i in numberOfBeatButtons)
              Container(
                decoration: BoxDecoration(
                  color: beatButtonBackColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: beatButtonSize,
                      width: beatButtonSize,
                      child: childRowB),
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i in numberOfBeatButtons)
              Container(
                decoration: BoxDecoration(
                  color: beatButtonBackColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: beatButtonSize,
                      width: beatButtonSize,
                      child: childRowC),
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i in numberOfBeatButtons)
              Container(
                decoration: BoxDecoration(
                  color: beatButtonBackColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: beatButtonSize,
                      width: beatButtonSize,
                      child: childRowD),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
