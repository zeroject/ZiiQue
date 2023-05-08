import 'package:test/test.dart';
import 'package:ziique/SoundEngine.dart';

void main() {
  group('soundEngine', () {
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

    }
    );
  test('ensure time is correctly generated at various bpm', () {
    //test cases with 3 paramethers, bpm, placement and expected time
    var inputsToExpect = {
      [200, 1, 300],
      [200, 16, 2400],
      [200, 8, 1200],
      [120, 1, 500],
      [120, 16, 4000],
      [120, 8, 2000],
      [60, 1, 1000],
      [60, 16, 8000],
      [60, 8, 4000],
      [20, 1, 2500],
      [20, 16, 20000],
      [20, 8, 10000],
      [0, 1, 0],
      [0, 16, 0],
      [0, 8, 0],
      [-1, 1, -1],
      [-1, 16, -1],
      [-1, 8, -1],
      [-100, 1, -100],
      [-100, 16, -100],
      [-100, 8, -100]
    };

    inputsToExpect.forEach((input) 
    {
      SoundEngine soundEngine = SoundEngine();
      soundEngine.changeBPM(input[0]);
      expect(soundEngine.convertBPMToTime(input[1]), input[2]);
     });

    }
    );    
  }
  );
}