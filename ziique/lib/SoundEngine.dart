import 'package:audioplayers/audioplayers.dart';

class SoundEngine {

AudioCache A = AudioCache(prefix: "assets/sounds/808.mp3");
AudioCache B = AudioCache(prefix: "assets/sounds/Hard_Kick.mp3");
AudioCache C = AudioCache(prefix: "assets/sounds/Hihat.mp3");
AudioCache D = AudioCache(prefix: "assets/sounds/Ride.mp3");
AudioCache E = AudioCache(prefix: "assets/sounds/snare_Claps.mp3");


int bpm = 120;

SoundEngine()
{
  //load the sound files into each cache
  

}

//function to change bpm by parameter
void changeBPM(int newBPM)
{
  bpm = newBPM;

}

//function to play a sound from the cache using a audio player
void playDemoSound(String beatNote)
{

  AudioPlayer player = AudioPlayer();
  //make a switch case that checks if beatNote mathces any of the audio cache objecs by name
  switch(beatNote)
  {
    case "A":
    player.audioCache = A;
    break;

    case "B":
    player.audioCache = B;
    break;

    case "C":
    player.audioCache = C;;
    break;

    case "D":
    player.audioCache = D;
    break;

    case "E":
    player.audioCache = E;
    break;

    default:
    print("No sound found");
    break;
  }

  //play the sound
  player.play;
}
}

