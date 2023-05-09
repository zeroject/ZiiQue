import 'package:audioplayers/audioplayers.dart';

class SoundEngine {
AudioPlayer player = AudioPlayer();
List<Node> nodes = [];

String beatString = "";

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

//function that converts bpm to correct time by placement¨
// where placement 1 is equal to the first beat of the bar
num convertBPMToTime(num placement)
{
  //divedes 60 by bpm to get the time of one beat, times 1000 to get the time in milliseconds
  num time = 0;
  num beatTime = (60 / bpm * 1000);
  time = placement * beatTime;
  return time;
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

void playBeat(String beatString)
{
  List<String> beatList = beatString.split("");
  for(int i = 0; i < beatList.length; i++)
  {
    if(beatList[i] != " ")
    {
      playSingleSound(beatList[i]);
    }
  }

}

List<Node> convertStringToNodes(String beatString)
{
  List<String> beatList = beatString.split(";");
  beatList.removeLast();
  List<Node> nodeList = [];
  String placement = "";
  String time = "";
  for(int i = 0; i < beatList.length; i++)
  {
    //plits the string into 2 strings
    // the first string placement, contains only the first charater of the string
    // the second string timecontains the rest of the string
    placement = beatList[i][0];
    time = beatList[i][1];
    if (beatList[i].length > 2)
    {
      time +=beatList[i][2];
    };
    //converts the time string to int
    num timeInt = num.parse(time);
    //creates a node with the source and time
    Node node = Node(convertBPMToTime(timeInt), sourceFolder + soundFiles[placement]);
    //adds the node to the list
    nodeList.add(node);
  }
  nodes = nodeList;
  return nodeList;
}

//play each node from the list at its specified time in miliseconds starting from 0
void playNodes(List<Node> nodeList)
{
  for(int i = 0; i < nodeList.length; i++)
  {
    player.play(DeviceFileSource(nodeList[i].source));
    //waits for the time of the node to play the next node
    Future.delayed(Duration(milliseconds: nodeList[i].time.toInt()));
  }
}

}

class Node
{
  num time;
  String source;

  Node(this.time, this.source);
}
