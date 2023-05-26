import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:ziique/Settings/settings_widget.dart';

import '../FireService/fire_beat_Service.dart';
import '../FireService/fire_user_service.dart';
import '../models/beat.dart';
import '../models/user.dart' as beat_user;
import 'custom_expansion_tile.dart';

class CustomFriendListView extends StatelessWidget{
  
  const CustomFriendListView({
    super.key, 
    required this.beatuser,
    });
    
    final beat_user.User? beatuser;

  @override
  Widget build(BuildContext context) {
    return beatuser!.friends.isNotEmpty ? FirestoreListView(
      query: UserService().getFriends(beatuser!.friends),
      shrinkWrap: true,
      itemBuilder: (context, snapshot) { 
      beat_user.User friend = snapshot.data();
      return ListView(
        shrinkWrap: true,
        children: [
          ExpansionTile(
            textColor: const Color.fromARGB(255, 0, 0, 0),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            collapsedBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            collapsedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            title: Text(
              "${friend.firstname} ${friend.lastname}",
              style: const TextStyle(fontSize: 20)),
              children: [
            const ListTile(
              title: Text("A Description"), 
            ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 1,
                itemBuilder: (context, index){
                return FirestoreListView(
                  query: BeatService().getAllPublicBeatsFromUser(friend.uid),
                  shrinkWrap: true,
                  itemBuilder: (context, snapshot) {
                    Beat beat = snapshot.data();
                    return CustomExpansionTile(
                      isFriendBeat: true,
                      beat: beat,
                      fontSize: 20,
                      tileColor: const Color.fromARGB(255, 180, 180, 180),
                      tileRadius: 10,
                    );
                  },
                );
                }
              ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                  onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("WARNING", style: TextStyle(
                            color: Color.fromARGB(255, 255, 60, 60)
                          ),),
                          content: const Text(
                              "You are about to remove one of your friends. Are you sure this is what you wanted?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  List<String> tempList = beatuser!.friends;
                                  tempList.remove(friend.uid);
                                  UserService().updateUser(
                                    beat_user.User(
                                    uid: FirebaseAuth.instance.currentUser!.uid, 
                                    firstname: beatuser!.firstname, 
                                    lastname: beatuser!.lastname, 
                                    friends: tempList,
                                    profileImgUrl: beatuser!.profileImgUrl
                                    )
                                  );
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPageMobile(context, initalScene: 'Friends',)));
                                },
                                child: const Text("Yes"))
                          ],
                    ));
                  }, 
                  child: const Text("Remove Friend", style: TextStyle(color: Colors.white),))
              ],
            )
          ],
      ),
        const SizedBox(
          height: 5,
      )
        ],
      ); 
      }
    ) : const Text("You have no friends", style: TextStyle(fontSize: 30, color: Colors.white),);
  }
}