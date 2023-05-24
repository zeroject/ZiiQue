import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import '../FireService/RealtimeData/fire_beatIt_realtime_service.dart';
import '../FireService/fire_user_service.dart';
import '../models/user.dart' as beat_user;

class CustomFriendInvListView extends StatelessWidget {
  const CustomFriendInvListView({
    super.key,
    required this.beatuser,
    required this.sessionID,
  });

  final beat_user.User? beatuser;
  final String sessionID;

  @override
  Widget build(BuildContext context) {
    return beatuser!.friends.isNotEmpty
        ? FirestoreListView(
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
                    collapsedBackgroundColor:
                        const Color.fromARGB(255, 255, 255, 255),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    collapsedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    title: Text("${friend.firstname} ${friend.lastname}",
                        style: const TextStyle(fontSize: 20)),
                    children: [
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              FireBeatItRealtimeService().addFriendToBeatItSession(sessionID, friend);
                            },
                            child: const Text("Send Inv"),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              );
            })
        : const Text(
            "No friends",
            style: TextStyle(fontSize: 50, color: Colors.white),
          );
  }
}
