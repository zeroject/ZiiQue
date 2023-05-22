import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:ziique/CustomWidgets/change_credentials_widget.dart';
import 'package:ziique/FireService/fire_beat_service.dart';
import 'package:ziique/models/fire_user.dart';
import '../CustomWidgets/custom_expansion_tile.dart';
import '../CustomWidgets/loadingscreen.dart';
import '../FireService/fire_user_service.dart';
import '../models/beat.dart';
import '../models/user.dart' as beat_user;
import '../models/fire_user.dart' as fire_user;
import 'package:qr_flutter/qr_flutter.dart';


String scene = "Account";
String friendcode = beatuser!.uid;
beat_user.User? beatuser;


const snackBar = SnackBar(content: Text('Code has been copied!'));


class SettingsPageDesktop extends StatelessWidget {
  const SettingsPageDesktop({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class SettingsPageMobile extends StatefulWidget {
    const SettingsPageMobile(BuildContext context, {super.key});

  @override
  State<SettingsPageMobile> createState() => _SettingsPageMobileState();
}

class _SettingsPageMobileState extends State<SettingsPageMobile> {
  bool light = true;
  bool light2 = true;
  bool light3 = true;
  TextEditingController addFriendController = TextEditingController();
  fire_user.User fireuser = FirebaseAuth.instance.currentUser!;
  final Future<beat_user.User?> userquery = Future(() => UserService().getUser(FirebaseAuth.instance.currentUser!.uid));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: userquery,
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return const Center(
                child: LoadingScreen(),
              );
          } else{
            beatuser = snapshot.data;
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (scene.contains('Account')) {
                return accountBuild(context);
              } else if(scene.contains('Payment')){
                return paymentBuild(context);
              } else if(scene.contains('Notifications')){
                return notificationsBuild(context);
              }else if(scene.contains('Security')){
                return securityBuild(context);
              }else if(scene.contains('Friends')){
                return friendBuild(context);
              }
              return accountBuild(context);

            });
          }
        }
      ),
    );
  }



Widget accountBuild(BuildContext context){

  return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('../../assets/images/ZiiQue-Logo.svg',
            width: 12,
            height: 12, 
            alignment: Alignment.topCenter,
          ),
          const SizedBox(
            width: 10
          ),
        ],
      ), backgroundColor: const Color.fromARGB(255, 44, 41, 41),),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Ziique_back_grey.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 600,
              height: MediaQuery.of(context).size.height - 56,
              color: Colors.black26.withOpacity(1),

              child:
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                    ],
                  ),
                  Container(
                    color: const Color.fromARGB(255, 57, 54, 54),
                    child:Padding(
                    padding: const EdgeInsets.all(81.0),
                    child: SizedBox(
                      width: 269,
                      child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Name: ', style: TextStyle(color: Colors.white, fontSize: 24),),
                            Text(beatuser!.firstname, style: const TextStyle(color: Colors.white, fontSize: 24),),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Email: ', style: TextStyle(color: Colors.white, fontSize: 24),),
                            Text(fireuser.email.toString(), style: const TextStyle(color: Colors.white, fontSize: 24),),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text('Your Friend Code:', style: TextStyle(color: Colors.white, fontSize: 14),),

                          Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(friendcode, style: const TextStyle(color: Colors.white, fontSize: 16, backgroundColor: Colors.grey),),

                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        OutlinedButton(style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                            onPressed: (){
                              Clipboard.setData(ClipboardData(text: friendcode))
                                  .then((value){ScaffoldMessenger
                                  .of(context)
                                  .showSnackBar(snackBar);});
                            },
                            child: const Text('Copy', style: TextStyle(color: Colors.white, fontSize: 24),)),
                          
                          OutlinedButton(
                            onPressed: (){
                              showDialog(
                                context: context, 
                                builder: (context) => AlertDialog(
                                  title: const Text("Friend QR-code"),
                                  content: SizedBox(
                                    height: 220,
                                    width: 220,
                                    child: QrImageView(data: beatuser!.uid, size: 200,)
                                  ),
                                  actions: [
                                    OutlinedButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      }, 
                                      child: const Text("Ok")
                                    )
                                  ],
                                ));
                            },
                            child: const Text("Show QR-code", style: TextStyle(fontSize: 20),))
                      ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]
      ),
    ),
  );
}

Widget paymentBuild(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('../../assets/images/ZiiQue-Logo.svg',
            width: 12,
            height: 12, 
            alignment: Alignment.topCenter,
        ),
        const SizedBox(
            width: 10
        ),
      ],
    ), backgroundColor: const Color.fromARGB(255, 44, 41, 41),),
    body: Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Ziique_back_grey.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 600,
            height: MediaQuery.of(context).size.height - 56,
            color: Colors.black26.withOpacity(1),

            child:
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                    OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                    OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                    OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                    OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                  ],
                ),
                Container(
                  color: const Color.fromARGB(255, 57, 54, 54),
                  child: Padding(
                  padding: const EdgeInsets.all(81),
                  child: SizedBox(
                    width: 269,
                    child: Column(
                    children: [
                      Text(beatuser!.firstname, style: const TextStyle(color: Colors.white, fontSize: 24),),
                      const SizedBox(
                        height: 100,
                      ),
                      const Text('Add a credit card', style: TextStyle(color: Colors.white, fontSize: 24),),
                      Container(
                        width: 250,
                        height: 100,
                        color: Colors.grey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Visa Credit Card', style: TextStyle(fontSize: 22, color: Colors.white),),
                            Text('Ends in 5847', style: TextStyle(fontSize: 22, color: Colors.white),),
                            Text('06/25', style: TextStyle(fontSize: 22, color: Colors.white),),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(onPressed: (){}, child: const Text('Add Card', style: TextStyle(decoration: TextDecoration.underline,fontSize: 24, color: Colors.white),))
                    ],
                  ),
                  )
                  
                )
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
  Widget notificationsBuild(BuildContext context){

    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('../../assets/images/ZiiQue-Logo.svg',
            width: 12,
            height: 12, 
            alignment: Alignment.topCenter,
          ),
          const SizedBox(
              width: 10
          ),
        ],
      ), backgroundColor: const Color.fromARGB(255, 44, 41, 41),),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Ziique_back_grey.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 600,
              height: MediaQuery.of(context).size.height - 56,
              color: Colors.black26.withOpacity(1),

              child:
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                    ],
                  ),
                  Container(
                    color: const Color.fromARGB(255, 57, 54, 54),
                    child: Padding(
                    padding: const EdgeInsets.all(81),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 269,
                          child: Row(children: [
                          const Text('Friend Requests', style: TextStyle(fontSize: 18, color: Colors.white), ),
                          Switch(value: light, activeColor: Colors.blue, onChanged: (bool value){setState(() {light = value;});}),
                        ],),),
                        SizedBox(
                          width: 269,
                          child: Row(children: [
                          const Text('General', style: TextStyle(fontSize: 18, color: Colors.white),),
                          Switch(value: light2, activeColor: Colors.blue, onChanged: (bool value){setState(() {light2 = value;});}),
                        ],),),
                        
                        SizedBox(
                          width: 269,
                          child: Row(children: [
                          const Text('Updates', style: TextStyle(fontSize: 18, color: Colors.white),),
                          Switch(value: light3, activeColor: Colors.blue, onChanged: (bool value){setState(() {light3 = value;});}),
                        ],),),
                        
                      ],
                    ),
                  )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
    Widget securityBuild(BuildContext context){
      return Scaffold(
        appBar: AppBar(title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('../../assets/images/ZiiQue-Logo.svg',
            width: 12,
            height: 12, 
            alignment: Alignment.topCenter,
            ),
            const SizedBox(
                width: 10
            ),
          ],
        ), backgroundColor: const Color.fromARGB(255, 44, 41, 41),),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Ziique_back_grey.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 600,
                height: MediaQuery.of(context).size.height - 56,
                color: Colors.black26.withOpacity(1),

                child:
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Security'; setState((){});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      ],
                    ),
                      Container(
                        color: const Color.fromARGB(255, 57, 54, 54),
                        child: Padding(
                        padding: const EdgeInsets.all(81),
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 220,
                                width: 269,
                                child: CustomCredentialsChange(
                                  emailOrPassword: 'Email', 
                                ),
                              ),
                              SizedBox(
                                height: 220,
                                width: 269,
                                child: CustomCredentialsChange(
                                  emailOrPassword: 'Password', 
                                ),
                              )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    Widget friendBuild(BuildContext context){
      return Scaffold(
        appBar: AppBar(title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('../../assets/images/ZiiQue-Logo.svg',
            width: 12,
            height: 12, 
            alignment: Alignment.topCenter,
            ),
            const SizedBox(
                width: 10
            ),
          ],
        ), backgroundColor: const Color.fromARGB(255, 44, 41, 41),),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Ziique_back_grey.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 600,
                height: MediaQuery.of(context).size.height - 56,
                color: Colors.black26.withOpacity(1),

                child:
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutlinedButton(onPressed: (){scene = 'Account'; setState(() {});}, child: const Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Payment'; setState(() {});}, child: const Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Security'; setState(() {});}, child: const Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                        OutlinedButton(onPressed: (){scene = 'Friends'; setState(() {});}, child: const Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),)),
                      ],
                    ),
                    Container(
                      color: const Color.fromARGB(255, 57, 54, 54),
                      child: Padding(
                        padding: const EdgeInsets.all(81),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 600,
                              width: 269,
                              child: SingleChildScrollView(
                                child: beatuser!.friends.isNotEmpty ? FirestoreListView(
                                query: UserService().getFriends(beatuser!.friends),
                                shrinkWrap: true,
                                itemBuilder: (context, snapshot) { 
                                  beat_user.User friend = snapshot.data();
                                  return ListView(
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
                                        SingleChildScrollView(
                                          child: FirestoreListView(
                                            query: BeatService().getAllPublicBeatsFromUser(FirebaseAuth.instance.currentUser!.uid),
                                            shrinkWrap: true,
                                            itemBuilder: (context, snapshot) {
                                              Beat beat = snapshot.data();
                                              return CustomExpansionTile(
                                                isFriendBeat: true,
                                                beat: beat,
                                                fontSize: 20,
                                                tileColor: const Color.fromARGB(255, 255, 255, 255),
                                                tileRadius: 10,
                                              );
                                            },
                                          ),
                                        ),
                                        ButtonBar(
                                          alignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            OutlinedButton(onPressed: (){
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
                                                                friends: tempList)
                                                              );
                                                            },
                                                            child: const Text("Yes"))
                                                      ],
                                              ));
                                            }, 
                                            child: const Text("Remove Friend"))
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
                                ) : const Text("No friends", style: TextStyle(fontSize: 50, color: Colors.white),)
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 269,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      TextFormField(
                                        controller: addFriendController,
                                        decoration: const InputDecoration(hintText: "Friendcode"),
                                      ),
                                      OutlinedButton(
                                        onPressed: (){
                                          List<String> friends = beatuser!.friends;
                                          friends.add(addFriendController.text);
                                          UserService().updateFriendList(friends);
                                        }, 
                                        child: const Text("Add Friend", 
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      OutlinedButton(
                                        onPressed: (){
                                          if (kIsWeb){

                                          }
                                        }, 
                                        child: const Text("Scan QR-code"))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}