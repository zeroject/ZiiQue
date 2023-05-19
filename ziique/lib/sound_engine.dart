import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class SoundEngine {
AudioPlayer player = AudioPlayer();
List<Node> nodes = [];

bool repeat = false;
bool shouldPlay = true;

String beatString = "";

String sourceFolder = "assets/samples/";
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
  return time;
}

void playSingleSound(String soundName)
{
  try
  {
     player.play(DeviceFileSource(sourceFolder + soundFiles[soundName]));
  }
  catch(e)
  {
    throw Exception("Sound not found");
  } 
}

void addToBeat(int pos, int rowMax, int beatMax)
{
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
      node += (pos % 16).toString();
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

  // ignore: unused_element
  void addNode(String beat)
  {
    //adds the string to the beatString
    beatString += beat;
  }

  // ignore: unused_element
  void removeNode(String beat)
  {
    //removes the string from the beatString
    beatString = beatString.replaceAll(beat, "");
  }

}

//returns a list of lists of nodes, each list contains all nodes of a specific placement, sorted by time
List<List<Node>> convertStringToNodes(String beatString)
{
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
    Node node = Node(convertBPMToTime(timeInt), sourceFolder + soundFiles[placement]);
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
void playNodes(List<Node> nodes, int playerCount)
{
  List<AudioPlayer> players = getPlayers(playerCount);
  int j = 0;
  int i = 0;
  //create a timer, that counts up, in miliseconds
  Timer timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
    //calculate the elapsed time, starting at 0
    //if the timer is at the time of the node, play the node
      if (timer.tick >= (nodes[i].time.toInt() / 10) + 1)
      {
        if (players[j].state == PlayerState.playing) 
         {
          j == playerCount -1 ? j = 0 : j++;  
          }
         players[j].play(DeviceFileSource(nodes[i].source));
         i == nodes.length -1 ? timer.cancel() : j++;  
    }

    //if the timer is at the end of the last node, cancel the timer
    if (timer.tick == (nodes.last.time /10) +1 && repeat == false)
    {
      timer.cancel();
    }
    else if (timer.tick == nodes.last.time && repeat == true)
    {
      timer.cancel();
      playNodes(nodes, playerCount);
    }
  });
}

//TODO fix error index out of bounce L266 and L224
play()
  {
    shouldPlay = true;
    List<List<Node>> nodes = convertStringToNodes(beatString).toList();
    for(int i = 0; i < nodes.length; i++)
    {

      if (nodes[i].length > 0)
      {
      playNodes(nodes[i], 2);
      }
    }
    return shouldPlay;
  }
}

class Node
{
  num time;
  String source;

  Node(this.time, this.source);
}
