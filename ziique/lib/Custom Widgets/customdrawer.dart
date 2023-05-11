import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../FireService/Fire_BeatService.dart';
import '../models/beat.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer(
      {super.key,
      @required required this.drawerWidth,
      required this.backgroundColor,
      required this.firebaseAuthUser,
      required this.drawerHeadHeight,
      required this.beatList,
      required this.settingsButHeight,
      required this.settingsButWidth,
      required this.settingsPageDesktop,
      required this.settingsPageMobile,
      required this.offsetHeight,
      required this.createAccButHeight,
      required this.createAccButWidth,
      required this.createButColor,
      required this.kIsWeb,
      required this.createPageDesktop,
      required this.createPageMobile,
      required this.loginButHeight,
      required this.loginButWidth,
      required this.loginPageDesktop,
      required this.loginPageMobile});

  final double drawerWidth;
  final Color backgroundColor;
  final bool firebaseAuthUser;
  final double drawerHeadHeight;
  final List beatList;
  final double settingsButHeight;
  final double settingsButWidth;
  final Widget settingsPageDesktop;
  final Widget settingsPageMobile;

  //Not logged in
  final double offsetHeight;
  final double createAccButHeight;
  final double createAccButWidth;
  final Color createButColor;
  final bool kIsWeb;
  final Widget createPageDesktop;
  final Widget createPageMobile;
  final double loginButHeight;
  final double loginButWidth;
  final Widget loginPageDesktop;
  final Widget loginPageMobile;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.drawerWidth,
      child: Drawer(
        backgroundColor: widget.backgroundColor,
        child: ListView(
          children: <Widget>[
            if (widget.firebaseAuthUser) ...[
              SizedBox(
                height: widget.drawerHeadHeight,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                  ),
                  child: Stack(
                    children: const [
                      Positioned(
                        bottom: 8.0,
                        left: 4.0,
                        child: Text(
                          "YOUR BEATS",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FirestoreListView<Beat>(
                shrinkWrap: true,
                query: BeatService().GetBeats(FirebaseAuth.instance.currentUser!), 
                itemBuilder: (BuildContext context, snapshot) {
                  Beat beat =  snapshot.data();
                  bool isOpen = false;
                  List<bool> _isOpen = [];
                  return ExpansionPanelList(
                      children: [
                        ExpansionPanel(
                          headerBuilder: (context, isOpen){
                            return Text(beat.title);
                          }, 
                          isExpanded: isOpen,
                          body: Text(beat.beatString)
                        )
                      ],
                      expansionCallback: (i, isOpen) =>
                        setState(() =>
                          _isOpen[i] = !isOpen
                        )

                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        width: widget.settingsButWidth,
                        height: widget.settingsButHeight,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => widget.settingsPageDesktop));
                          },
                          child: const Text("Account Settings",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: widget.settingsButWidth,
                        height: widget.settingsButHeight,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => widget.settingsPageMobile));
                          },
                          child: const Text(
                            "Log Out",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Column(
                children: [
                  SizedBox(
                    height: widget.offsetHeight,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "It seems you are not logged in",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    child: SizedBox(
                      height: widget.createAccButHeight,
                      width: widget.createAccButWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: widget.createButColor),
                        onPressed: () {
                          if (widget.kIsWeb) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => widget.createPageDesktop));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => widget.createPageMobile));
                          }
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  Align(
                    child: SizedBox(
                      height: widget.loginButHeight,
                      width: widget.loginButWidth,
                      child: TextButton(
                        onPressed: () {
                          if (widget.kIsWeb) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => widget.loginPageDesktop));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => widget.loginPageMobile));
                          }
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => widget.settingsPageMobile));
                    },
                    child: const Text("Account Settings",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
