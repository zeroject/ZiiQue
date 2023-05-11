import 'package:audioplayers/audioplayers.dart';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:ziique/BeatBoard/BeatBoard-Widget.dart';
import 'package:ziique/models/beat.dart';

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

SoundEngine()
{
  
}

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
    print(soundName);
     player.play(DeviceFileSource(sourceFolder + soundFiles[soundName]));
  }
  catch(e)
  {
    throw Exception("Sound not found");
  } 
}

void addToBeat(String beat)
{
  //adds the string to the beatString + differentiates between different beats
  String newBeat = "$beat;";
  beatString += newBeat;
}

void removeFromBeat(String beat)
{
  //removes the string from the beatString
  String newBeat = "$beat;";
  beatString = beatString.replaceAll(newBeat, "");
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

  void addNode(String beat)
  {
    //adds the string to the beatString
    beatString += beat;
  }

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
  List<Node> NodeA = [];
  List<Node> NodeB = [];
  List<Node> NodeC = [];
  List<Node> NodeD = [];
  List<Node> NodeE = []; 
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
    };
    //converts the time string to int
    num timeInt = num.parse(time);

    //creates a node with the source and time
    Node node = Node(convertBPMToTime(timeInt), sourceFolder + soundFiles[placement]);
    switch (placement) {
      case "A":
        NodeA.add(node);  
        break;
      case "B":
        NodeB.add(node);  
        break;
      case "C":
        NodeC.add(node);  
        break;
      case "D":
        NodeD.add(node);  
        break;
      case "E":
        NodeE.add(node);  
        break;
      default:
      throw Exception("placement not found");
    }
  }
  nodeList.add(NodeA);
  nodeList.add(NodeB);
  nodeList.add(NodeC);
  nodeList.add(NodeD);
  nodeList.add(NodeE);

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
void playNodes(List<Node> nodeList, int playerCount)
{
  List<AudioPlayer> players = getPlayers(playerCount);
  int miliDelay = nodeList[0].time.toInt();

  //plays the node in nodelist, if the current player from players in playing, take the next player
  int j = 0;
  for(int i = 0; i < nodeList.length; i++)
  {
    if (players[j].state == PlayerState.playing)
    {
      j == playerCount ? j = 0 : j++;
    }
    players[i].play(DeviceFileSource(nodeList[i].source));
  

  //sets the delay to the first node time
  for(int i = 0; i < nodeList.length; i++)
  {
    //waits for the time of the node to play the next node from 0 to the specified time
    Future.delayed(Duration(milliseconds: miliDelay));

    if (repeat && i == nodeList.length - 1) { i = 0; }

    else if ( i >=1 && i < nodeList.length - 1)
    {
      miliDelay = nodeList[i].time.toInt() - nodeList[i+1].time.toInt();
    }
  }
  }
}


  void play()
  {
    List<List<Node>> nodes = convertStringToNodes(beatString);
    for(int i = 0; i < nodes.length; i++)
    {
      playNodes(nodes[i], 2);
    }

  }

}

class Node
{
  num time;
  String source;

  Node(this.time, this.source);
}
