import 'package:flutter_test/flutter_test.dart';
import 'package:ziique/sound_engine.dart';

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

    for (var input in inputsToExpect) {
      SoundEngine soundEngine = SoundEngine();
      soundEngine.changeBPM(input[0]);
      expect(soundEngine.convertBPMToTime(input[1]), input[2]);
     }
  });

  test('beatString to list of nodes correctly with 120 bpm', () {
    //arrange
    SoundEngine soundEngine = SoundEngine();
    String beatString = "A1;B2;C3;D4;E5;A6;B7;C8;D9;E10;B12;A11;C13;D14;E15;A16;";
    String sourceFolder = "assets/samples/";
    Map soundFiles = {
    "A": "808.mp3",
    "B": "Hard_Kick.mp3",
    "C": "Hihat.mp3",
    "D": "Ride.mp3",
    "E": "Snare_Claps.mp3"
};
    List<Node> expectedNodesA = [
      Node(500, sourceFolder + soundFiles["A"]),
      Node(3000, sourceFolder +soundFiles["A"]),
      Node(5500, sourceFolder +soundFiles["A"]),
      Node(8000, sourceFolder +soundFiles["A"]),
    ];

    List<Node> expectedNodesB = [
      Node(1000, sourceFolder +soundFiles["B"]),
      Node(3500, sourceFolder +soundFiles["B"]),
      Node(6000, sourceFolder +soundFiles["B"]),
    ];

    List<Node> expectedNodesC = [
      Node(1500, sourceFolder +soundFiles["C"]),
      Node(4000, sourceFolder +soundFiles["C"]),
      Node(6500, sourceFolder +soundFiles["C"]),
    ];

    List<Node> expectedNodesD = [
      Node(2000, sourceFolder +soundFiles["D"]),
      Node(4500, sourceFolder +soundFiles["D"]),
      Node(7000, sourceFolder +soundFiles["D"]),
    ];

    List<Node> expectedNodesE = [
      Node(2500, sourceFolder +soundFiles["E"]),
      Node(5000, sourceFolder +soundFiles["E"]),
      Node(7500, sourceFolder +soundFiles["E"]),
    ];

    List<List<Node>> expectedNodes = [expectedNodesA, expectedNodesB, expectedNodesC, expectedNodesD, expectedNodesE];
    //act
    List<List<Node>> nodes = soundEngine.convertStringToNodes(beatString);

    //assert
    for (var j = 0; j < expectedNodes.length; j++) {
      for (var i = 0; i < expectedNodes[j].length; i++) {
        expect(nodes[j][i].time == expectedNodes[j][i].time && nodes[j][i].source == expectedNodes[j][i].source, true);
      }
    }
  });

  test("addToBeat from input to beatString", () {

    //arrange
  SoundEngine soundEngine = SoundEngine();
  int input2 = 5;
  int input3 = 4;
  List<int> input1 = [5, 30, 42, 16, 80];
  String expectedString = "A4;B12;C7;A15;E11;";
    //act
    for (var i = 0; i < input1.length; i++) {
      soundEngine.addToBeat(input1[i], input2, input3);
    }
    String result = soundEngine.beatString;

    //assert
    expect(result, expectedString);
  });

  test('removeFromBeat from input to beatString', () {
    //arrange
    SoundEngine soundEngine = SoundEngine();
    String expectedString = "A4;B12;A15;E11;";
    int input2 = 5;
    int input3 = 4;
    List<int> input1 = [5, 30, 42, 16, 80];
    int removeInput = 42;
    //act
    for (var i = 0; i < input1.length; i++) {
      soundEngine.addToBeat(input1[i], input2, input3);
    }
    soundEngine.removeFromBeat(removeInput, input2, input3);
    //assert
    expect(soundEngine.beatString, expectedString);
  
  });

  test('can soundEngine play', () {
    //arrange
    SoundEngine soundEngine = SoundEngine();
    int bar = 4;
    int row = 5;
    List<int> input = [5, 30, 42, 16, 80];
    for (var i = 0; i < input.length; i++) {
      soundEngine.addToBeat(input[i], row, bar);
    }
    //act
    bool result = soundEngine.play();
    //assert
    expect(result, true);
  });
  });
}