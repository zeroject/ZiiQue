import 'package:audioplayers/audioplayers.dart';

class SoundEngine {

AudioCache cache = AudioCache();
AudioPlayer player = AudioPlayer();

String sourceFolder = "assets/";
Map soundFiles = {
  "A": "808.mp3",
  "B": "Hard_Kick.mp3",
  "C": "Hihat.mp3",
  "D": "Ride.mp3",
  "E": "Snare_Claps.mp3"
};

int bpm = 120;

SoundEngine()
{
  
}

//function to change bpm by parameter
void changeBPM(int newBPM)
{
  bpm = newBPM;

}

void playSingleSound(String soundName)
{
  try
  {
    print(soundName);
     player.play(DeviceFileSource("assets/" + soundFiles[soundName]));
  }
  catch(e)
  {
    throw Exception("Sound not found");
  } 
  
}
}

