import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class SoundEngine {
AudioPlayer player = AudioPlayer();
List<Node> nodes = [];

bool repeat = false;
bool shouldPlay = false;

String beatString = "";

String sourceFolder = "samples/";
String theme = "Hip-Hop/";
Map soundFiles = {
  "A": "808.mp3",
  "B": "Hard_Kick.mp3",
  "C": "Hihat.mp3",
  "D": "Ride.mp3",
  "E": "Snare_Claps.mp3"
};

Map beatMap = {
  "A": List<Node>,
  "B": List<Node>,
  "C": List<Node>,
  "D": List<Node>,
  "E": List<Node>,
};

int bpm = 120;


//function to change bpm by parameter
void changeBPM(int newBPM)
{
  bpm = newBPM;

}

void loadBeat(String newBeat)
{
  beatString = newBeat;
}

void stop()
{
  shouldPlay = false;
}

//function that converts bpm to correct time by placement¨
// where placement 1 is equal to the first beat of the bar
num convertBPMToTime(num placement)
{
  //divedes 60 by bpm to get the time of one beat, times 1000 to get the time in milliseconds
  num time = 0;
  num beatTime = (60 / bpm * 1000);
  time = placement * beatTime;
  return time /2;
}

void changeTheme(String newTheme)
{
  print(newTheme);
  switch (newTheme) {
    case "House":
    soundFiles["A"] = "Clap.wav";
    soundFiles["B"] = "Kick.wav";
    soundFiles["C"] = "Shaker.wav";
    soundFiles["D"] = "Ride.wav";
    soundFiles["E"] = "Snare.wav";
      break;
    case "Hip-Hop":
    soundFiles["A"] = "808.mp3";
    soundFiles["B"] = "Hard_Kick.mp3";
    soundFiles["C"] = "Hihat.mp3";
    soundFiles["D"] = "Ride.mp3";
    soundFiles["E"] = "Snare_Claps.mp3";
      break;
    case "Acoustic":
    soundFiles["A"] = "Hitom.wav";
    soundFiles["B"] = "Kick.wav";
    soundFiles["C"] = "Hihat.wav";
    soundFiles["D"] = "Ride.wav";
    soundFiles["E"] = "Snare.wav";
      break;
      case "Hardstyle":
        print("Should fucking change sounds motherfucker");
    soundFiles["A"] = "Kick.wav";
    soundFiles["B"] = "Shaker.wav";
    soundFiles["C"] = "Hat.wav";
    soundFiles["D"] = "Cym.wav";
    soundFiles["E"] = "Snare.wav";
      break;
  }
  theme = newTheme + "/";
}

void playSingleSound(int soundIndex)
{
  AudioPlayer player = AudioPlayer();
  String sound ="";
  
  switch (soundIndex) {
    case 0:
     sound = soundFiles["A"];
      break;
      case 17:
      sound = soundFiles["B"];
      break;
      case 34:
      sound = soundFiles["C"];
      break;
      case 51:
      sound = soundFiles["D"];
      break;
      case 68:
      sound = soundFiles["E"];
      break;
  }
  player.play(AssetSource(sourceFolder + theme + sound));
  
}

void playSingleSoundMobile(int soundIndex)
{
  AudioPlayer player = AudioPlayer();
  String sound ="";
  
  switch (soundIndex) {
    case 0:
     sound = soundFiles["A"];
      break;
      case 17:
      sound = soundFiles["B"];
      break;
      case 34:
      sound = soundFiles["C"];
      break;
      case 51:
      sound = soundFiles["D"];
      break;
      case 68:
      sound = soundFiles["E"];
      break;
  }
  player.play(AssetSource(sourceFolder + theme + sound));
  
}

void addToBeat(int pos, int rowMax, int beatMax)
{
  print(pos.toString() +"--" +rowMax.toString()  +"--" + beatString.toString());
  String node = nodeString(pos, rowMax, beatMax);
  node += ";";
  beatString = beatString + node;
}


void removeFromBeat (int pos, int rowMax, int beatMax)
{
  String node = nodeString(pos, rowMax, beatMax);
  node += ";";
  beatString = beatString.replaceAll(node, "");
}

String nodeString(int position, int rowCount, int beat) {
  List<num> greens = [];
  String node = "";
  num totalG = beat * 4 +1;
  num tempG = 0;
  Map beatMap = {
    0: "A",
    1: "B",
    2: "C",
    3: "D",
    4: "E"
  };
  for (var i = 0; i < rowCount; i++) {
    greens.add(tempG);
    tempG += totalG;
  }
  num rowL = beat*4+1;
  num total = rowL * rowCount;
  num pos = -1;
  num currentRow = 0;

  for (var i = 0; i < total; i++) {
    if (i == position) {
      node += beatMap[currentRow];
      node += (pos % ((beat * 4) + 1)).toString();
      break;
    }
    else if (greens.contains(i) && i != 0)
    {
      currentRow++;
      pos-1;
      }
      else {
        pos++;
      }
  }
  return node;
}

//returns a list of ints, each int is a node
List<int> nodeInt( int beatMax)
{
  List<int> nodePosition = [];
  Map rowMap = {
    "A":1,
    "B":2,
    "C":3,
    "D":4,
    "E":5,
  };
  String rowString = "";
  String pos = "";
  int column = beatMax * 4;
  List<String> beatList = beatString.split(";");
  beatList.removeLast();
   for(int i = 0; i < beatList.length; i++)
  {
    //plits the string into 2 strings
    // the first string placement, contains only the first charater of the string
    // the second string timecontains the rest of the string
    rowString = beatList[i][0];
    pos = beatList[i][1];
    if (beatList[i].length > 2)
    {
      pos +=beatList[i][2];
    }
    //converts the time string to int
    num posInt = num.parse(pos);
    num rowInt = rowMap[rowString];
    num position = (column * (rowInt - 1)) + rowInt + posInt;
    nodePosition.add(position.toInt());
  }
  return nodePosition;
}


//returns a list of lists of nodes, each list contains all nodes of a specific placement, sorted by time
List<List<Node>> convertStringToNodes(String beatString)
{
  print(beatString);
  List<String> beatList = beatString.split(";");
  List<Node> nodeA = [];
  List<Node> nodeB = [];
  List<Node> nodeC = [];
  List<Node> nodeD = [];
  List<Node> nodeE = []; 
  beatList.removeLast();
  List<List<Node>> nodeList = [];
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
    }
    //converts the time string to int
    num timeInt = num.parse(time);

    //creates a node with the source and time
    Node node = Node(convertBPMToTime(timeInt), sourceFolder + theme + soundFiles[placement]);
    switch (placement) {
      case "A":
        nodeA.add(node);  
        break;
      case "B":
        nodeB.add(node);  
        break;
      case "C":
        nodeC.add(node);  
        break;
      case "D":
        nodeD.add(node);  
        break;
      case "E":
        nodeE.add(node);  
        break;
      default:
      throw Exception("placement not found");
    }
    print(soundFiles['A']);
  }
  nodeList.add(nodeA);
  nodeList.add(nodeB);
  nodeList.add(nodeC);
  nodeList.add(nodeD);
  nodeList.add(nodeE);

//sort all lists in nodeList by time from lowest to highest
  for(int i = 0; i < nodeList.length; i++)
  {
    nodeList[i].sort((a, b) => a.time.compareTo(b.time));
  }

  return nodeList;

}

//create a list of audioplayers with the specified playercount to avoid overloading a single player
 List<AudioPlayer> getPlayers(int playerCount) {
    List<AudioPlayer> players = [];
    for (int i = 0; i < playerCount; i++) {
      players.add(AudioPlayer());
    }
    return players;
  }

//play each node from the list at its specified time in miliseconds starting from 0
void playNodes(List<Node> nodes, int playerCount, num time)
{
  List<AudioPlayer> players = getPlayers(playerCount);
  int j = 0;
  int i = 0;
  //create a timer, that counts up, in miliseconds
  Timer timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
    //calculate the elapsed time, starting at 0
    //if the timer is at the time of the node, play the node
    if (shouldPlay == true)
    {
      if (timer.tick >= (nodes[i].time.toInt() / 10) + 1)
      {
        if (players[j].state == PlayerState.playing) 
         {
          j == playerCount -1 ? j = 0 : j++;  
          }

         players[j].play(DeviceFileSource(nodes[i].source));
         (i == nodes.length -1) ? timer.cancel() : i++;  
    }
    }else 
    {
      timer.cancel();
    }

    if (timer.tick >= time)
    {
      shouldPlay = false;
    }
  });
}

play()
  {
    //alternate between shouldPlay and !shouldPlay
    if (shouldPlay == false)
    {
      print(
        shouldPlay.toString() + " 2"
      );
    shouldPlay = true;
    num maxTime = 0;
    List<List<Node>> nodes = convertStringToNodes(beatString).toList();
    for (var node in nodes) {
      if (node.isNotEmpty && node.last.time > maxTime) {
        maxTime = node.last.time;
      }
    }
    maxTime = ((maxTime /10) +1);
    for(int i = 0; i < nodes.length; i++)
    {

      if (nodes[i].isNotEmpty)
      {
      playNodes(nodes[i], 2, maxTime);
      }
    }
}
else
{
  shouldPlay = false;
}
  }
}

class Node
{
  num time;
  String source;

  Node(this.time, this.source);
}
