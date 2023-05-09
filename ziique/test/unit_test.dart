import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ziique/SoundEngine.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('SoundEngine', () {
    test('ensure start bpm is 120', () {
    //arrange
    SoundEngine soundEngine = SoundEngine();
    //act
    int bpm = soundEngine.bpm;
    //assert
    expect(bpm, 120);
  });

  test('ensure bpm is starting at correct bpm', () {
      var inputsToExpect = {
        120: 120,
        60: 60,
        20: 20,
        0: 0,
        -1: -1,
        -100: -100,
      };
      SoundEngine soundEngine = SoundEngine();
      inputsToExpect.forEach((input, expected) {
        soundEngine.changeBPM(input);
        expect(soundEngine.bpm, expected);
      });
  });

  test('ensure bpm is converted correctly to time by placement', () {
    //test cases with 3 paramethers, bpm, placement and expected time
    var inputsToExpect = {
      [200, 1, 300],
      [200, 16, 4800],
      [200, 8, 2400],
      [120, 1, 500],
      [120, 16, 8000],
      [120, 8, 4000],
      [60, 1, 1000],
      [60, 16, 16000],
      [60, 8, 8000],
      [20, 1, 3000],
      [20, 16, 48000],
      [20, 8, 24000],
    };

    inputsToExpect.forEach((input) 
    {
      SoundEngine soundEngine = SoundEngine();
      soundEngine.changeBPM(input[0]);
      expect(soundEngine.convertBPMToTime(input[1]), input[2]);
     });
  });

  test('beatString to list of nodes correctly with 120 bpm', () {
    //arrange
    SoundEngine soundEngine = SoundEngine();
    String beatString = "A1;B2;C3;D4;E5;A6;B7;C8;D9;E10;A11;B12;C13;D14;E15;A16;";
    String sourceFolder = "assets/";
    Map soundFiles = {
    "A": "808.mp3",
    "B": "Hard_Kick.mp3",
    "C": "Hihat.mp3",
    "D": "Ride.mp3",
    "E": "Snare_Claps.mp3"
};
    List<Node> expectedNodes = [
      Node(500, sourceFolder + soundFiles["A"]),
      Node(1000, sourceFolder +soundFiles["B"]),
      Node(1500, sourceFolder +soundFiles["C"]),
      Node(2000, sourceFolder +soundFiles["D"]),
      Node(2500, sourceFolder +soundFiles["E"]),
      Node(3000, sourceFolder +soundFiles["A"]),
      Node(3500, sourceFolder +soundFiles["B"]),
      Node(4000, sourceFolder +soundFiles["C"]),
      Node(4500, sourceFolder +soundFiles["D"]),
      Node(5000, sourceFolder +soundFiles["E"]),
      Node(5500, sourceFolder +soundFiles["A"]),
      Node(6000, sourceFolder +soundFiles["B"]),
      Node(6500, sourceFolder +soundFiles["C"]),
      Node(7000, sourceFolder +soundFiles["D"]),
      Node(7500, sourceFolder +soundFiles["E"]),
      Node(8000, sourceFolder +soundFiles["A"]),
    ];
    //act
    List<Node> nodes = soundEngine.convertStringToNodes(beatString);

    //assert
    for (var i = 0; i < expectedNodes.length; i++) {
      expect(nodes[i].time == expectedNodes[i].time && nodes[i].source == expectedNodes[i].source, true);
    }
  });
  });
}