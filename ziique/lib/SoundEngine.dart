import 'package:audioplayers/audioplayers.dart';

class SoundEngine {

AudioCache cache = AudioCache();
AudioPlayer player = AudioPlayer();

String sourceFolder = "assets/samples/";
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
    //load all sounds into cache
  soundFiles.forEach((key, value) {
    cache.load(sourceFolder + value);
    print("loaded " + sourceFolder + value);

  });
  player.audioCache = cache;
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
     player.play(AssetSource(sourceFolder + soundFiles[soundName]));
  }
  catch(e)
  {
    throw Exception("Sound not found");
  } 
  
}
}

