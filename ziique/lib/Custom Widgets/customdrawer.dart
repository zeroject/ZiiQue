import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        backgroundColor: backgroundColor,
        child: ListView(
          children: <Widget>[
            if (firebaseAuthUser) ...[
              SizedBox(
                height: drawerHeadHeight,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: backgroundColor,
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
              for (var i in beatList)
                ListTile(
                  title: Text(i.toString()),
                  tileColor: const Color.fromARGB(255, 217, 217, 217),
                ),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        width: settingsButWidth,
                        height: settingsButHeight,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => settingsPageDesktop));
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
                        width: settingsButWidth,
                        height: settingsButHeight,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => settingsPageMobile));
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
                    height: offsetHeight,
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
                      height: createAccButHeight,
                      width: createAccButWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: createButColor),
                        onPressed: () {
                          if (kIsWeb) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => createPageDesktop));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => createPageMobile));
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
                      height: loginButHeight,
                      width: loginButWidth,
                      child: TextButton(
                        onPressed: () {
                          if (kIsWeb) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginPageDesktop));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginPageMobile));
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
                              builder: (context) => settingsPageMobile));
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
