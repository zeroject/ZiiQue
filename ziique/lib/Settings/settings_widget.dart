import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:ziique/CustomWidgets/change_credentials_widget.dart';
import 'package:ziique/FireService/fire_auth_service.dart';
import 'package:ziique/CustomWidgets/custom_friend_listview.dart';
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
  TextEditingController changeDisplayName = TextEditingController();



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
                      !kIsWeb ? OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)) :
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
                            const Text('Name: ', style: TextStyle(color: Colors.white, fontSize: 24),),
                            Text(beatuser!.firstname, style: const TextStyle(color: Colors.white, fontSize: 24),),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Email: ', style: TextStyle(color: Colors.white, fontSize: 24),),
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
                            child: const Text("Show QR-code", style: TextStyle(fontSize: 20),)),
                        SizedBox(
                          height: 100,
                        ),
                        TextFormField(controller: changeDisplayName, decoration: InputDecoration(hintText: 'Change Display Name', hintStyle: TextStyle(color: Colors.white, fontSize: 16)),),
                        ElevatedButton(onPressed: (){
                          ChangeCredentialsService().changeDisplayName(changeDisplayName.text);
                        }, child: Text('Set Name', style: TextStyle(color: Colors.white, fontSize: 16),)),
                        SizedBox(
                          height: 120,
                        ),
                        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),onPressed: (){
                          showDialog(context: context, builder: (context) => AlertDialog(
                          title: const Text('You are trying to delete your Account, Are you sure?'),
                          content: SizedBox(
                            height: 220,
                            width: 220,
                          ),
                          actions: [
                            ElevatedButton(onPressed: (){
                              Navigator.pop(context);
                            },
                                child: const Text('Cancel')),
                            ElevatedButton(onPressed: (){
                              UserService().deleteUser();
                            }, child: const Text('Delete Account'))
                          ],
                        ));}, child: Text('Delete Account', style: TextStyle(color: Colors.white, fontSize: 16),))
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
                    !kIsWeb ? OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)) :
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
                      !kIsWeb ? OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)) :
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
                        !kIsWeb ? OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)) :
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
                        !kIsWeb ? OutlinedButton(onPressed: (){scene = 'Notifications'; setState(() {});}, child: const Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)) :
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
                              height: 140,
                              width: 269,
                              child: ListView(
                                children: [
                                  TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    controller: addFriendController,
                                    decoration: const InputDecoration(
                                      hintText: "Insert Friendcode",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blueAccent),), 
                                          labelStyle: TextStyle(
                                            color: Colors.white), 
                                            hintStyle: TextStyle(
                                              color: Colors.white)),
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                                    onPressed: (){
                                      List<String> friends = beatuser!.friends;
                                      friends.add(addFriendController.text);
                                      UserService().updateFriendList(friends);
                                    }, 
                                    child: const Text("Add Friend with code", 
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                                    onPressed: (){

                                    }, 
                                    child: const Text("Scan QR-code", style: TextStyle(color: Colors.white,))),
                                      ],
                                    ),
                                  ),
                              SizedBox(
                                height: 200,
                                width: 269,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    CustomFriendListView(
                                      beatuser: beatuser
                                      ),
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