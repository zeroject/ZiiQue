import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ziique/Custom%20Widgets/beatboard.dart';
import 'package:ziique/Custom%20Widgets/customdrawer.dart';
import 'package:ziique/login-create/Create-Widget.dart';
import 'package:ziique/login-create/Login-Widget.dart';
import '../Settings/Settings-Widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color beatInfo = const Color.fromARGB(255, 72, 72, 72);
Color beatNorm = const Color.fromARGB(255, 0, 178, 255);
Color beatNormPress = const Color.fromARGB(255, 0, 105, 147);
List<int> test = [1, 2, 3, 4];
List<bool> _bools = List.generate(numberOfRows * ((numberOfBars * 4) + 1), (index) => false);
int numberOfRows = 8;
int numberOfBars = 4;
int maxRange = (numberOfBars * 4);
int minRange = 1;

class BeatBoardApp extends StatelessWidget {
  BeatBoardApp(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 44, 41, 41),
        leading: Center(
          child: Image.asset(
            "assets/images/madebyzomr.png",
            fit: BoxFit.cover,
          ),
        ),
        leadingWidth: 45,
        title: Center(
          child: Image.asset(
            "assets/images/ZiiQue-Logo.png",
            fit: BoxFit.cover,
            scale: 10,
          ),
        ),
        actions: [],
      ),
      endDrawer: CustomDrawer(
        drawerWidth: 450,
        backgroundColor: const Color.fromARGB(255, 44, 41, 41),
        firebaseAuthUser: FirebaseAuth.instance.currentUser != null,
        drawerHeadHeight: 64,
        beatList: [1, 2],
        settingsButHeight: 60,
        settingsButWidth: 290,
        settingsPageDesktop: SettingsPageMobile(context),
        settingsPageMobile: SettingsPageMobile(context),
        offsetHeight: 80,
        createAccButHeight: 40,
        createAccButWidth: 200,
        createButColor: const Color.fromARGB(255, 77, 77, 77),
        kIsWeb: kIsWeb,
        createPageDesktop: CreateDesktop(context),
        createPageMobile: CreateMobile(context),
        loginButHeight: 40,
        loginButWidth: 100,
        loginPageDesktop: LoginDesktop(context),
        loginPageMobile: LoginMobile(context),
      ),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/grey-background.png"),
              fit: BoxFit.none,
            ),
          ),
          child: Column(
            children: [
              ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5.0),
                  children: [
                    BeatBoard(
                      playBarWidth: 160,
                      playBarColor: Color.fromARGB(255, 81, 81, 81),
                      playBarRounding: 5,
                      playBarButtonSize: 45,
                      playBarFontSize: 6,
                      playBarOffset: 739,
                      beatButtonBackColor: Color.fromARGB(255, 42, 42, 42),
                      beatButtonSize: 45,
                      beatButtonSampleColor: beatInfo,
                      beatButtonNormColor: beatNorm,
                      beatButtonNormPressColor: beatNormPress,
                    ),
                  ]),
            ],
          )),
    );
  }
}

class BeatBoardDesktop extends StatefulWidget {
  BeatBoardDesktop(BuildContext context);

  @override
  State<BeatBoardDesktop> createState() => _BeatBoardDesktopState();
}

class _BeatBoardDesktopState extends State<BeatBoardDesktop> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 41, 41),
        leading: Center(
          child: Image.asset(
            "assets/images/madebyzomr.png",
            fit: BoxFit.cover,
          ),
        ),
        leadingWidth: 90,
        title: Center(
          child: Image.asset(
            "assets/images/ZiiQue-Logo.png",
            fit: BoxFit.cover,
            scale: 10,
          ),
        ),
        actions: [],
      ),
      endDrawer: CustomDrawer(
        drawerWidth: 450,
        backgroundColor: const Color.fromARGB(255, 44, 41, 41),
        firebaseAuthUser: FirebaseAuth.instance.currentUser != null,
        drawerHeadHeight: 64,
        beatList: [1, 2],
        settingsButHeight: 60,
        settingsButWidth: 290,
        settingsPageDesktop: SettingsPageMobile(context),
        settingsPageMobile: SettingsPageMobile(context),
        offsetHeight: 360,
        createAccButHeight: 40,
        createAccButWidth: 200,
        createButColor: const Color.fromARGB(255, 77, 77, 77),
        kIsWeb: kIsWeb,
        createPageDesktop: CreateDesktop(context),
        createPageMobile: CreateMobile(context),
        loginButHeight: 40,
        loginButWidth: 100,
        loginPageDesktop: LoginDesktop(context),
        loginPageMobile: LoginMobile(context),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/grey-background.png"),
            fit: BoxFit.none,
          ),
        ),
        /*
        BeatBoard settings starts here ---------------------------------------------------------------------------------------------------------------------
         */
        child: Column(
          children: [
            Center(
              child: Container(

              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(8),
                crossAxisCount: (numberOfBars * 4) + 1,
                children: [
                  for (var i = 0; i < ((numberOfBars * 4) + 1) * numberOfRows; i++)
                    Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: (i % ((numberOfBars * 4) + 1) == 0) ? Colors.green : BeatColor(bar: numberOfBars).getColor(i) ? (_bools[i] == true) ? Colors.grey[900] : Colors.grey : (_bools[i] == true) ? Colors.grey[900] : Colors.blueGrey
                          ),
                          onPressed: () {
                            setState(() {
                              _bools[i] = !_bools[i];
                              maxRange = (numberOfBars * 4);
                              minRange = 1;
                              });
                          },
                          child: Text(
                            (i % ((numberOfBars * 4) + 1) == 0) ? Alpha().getAlphebat()[i == 1 ? 1 : i~/((numberOfBars * 4) + 1)] : i.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Alpha {
  Alpha();

  List<String> getAlphebat() {
    List<String> alphabets = [];
    for (int i = 65; i <= 90; i++) {
      alphabets.add(String.fromCharCode(i));
    }
    return alphabets;
  }
}

class BeatColor{
  BeatColor({required this.bar});
  final int bar;

  bool getColor(int i){
    print("beatIndex: " + i.toString() + " maxRange: " + maxRange.toString() + (i == maxRange ? " true" : " false"));
     if (i == maxRange)
        {
            
          maxRange += (numberOfBars * 4) +1 ;
          minRange += (numberOfBars * 4) +1 ;
          maxRange += (numberOfBars * 4) +1 ;
          minRange += (numberOfBars * 4) +1;
          return true;
        }
      else if (i >= minRange && i <= maxRange)
      {
        return true;
        }
        else
        {
          return false;
          }
        }
        }
