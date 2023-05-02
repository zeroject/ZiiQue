import 'package:flutter/material.dart';

class SettingsPageDesktop extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}

class SettingsPageMobile extends StatelessWidget {
    SettingsPageMobile(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive app Test')),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 750) {
            return Build1(context);
          } else{
            return Build1(context);
          };
        }
    ),
    );
  }
}

Widget Build1(BuildContext context){
  return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/ZiiQue-Logo.png',
            scale: 12, alignment: Alignment.topCenter,
          ),
          const SizedBox(
            width: 10
          ),
        ],
      ), backgroundColor: Colors.black26,),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/grey-background.png"),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton(onPressed: (){}, child: Text('Account', style: TextStyle(fontSize: 24, color: Colors.white),)),
                  OutlinedButton(onPressed: (){}, child: Text('Payment', style: TextStyle(fontSize: 24, color: Colors.white),)),
                  OutlinedButton(onPressed: (){}, child: Text('Notifications', style: TextStyle(fontSize: 24, color: Colors.white),)),
                  OutlinedButton(onPressed: (){}, child: Text('Security', style: TextStyle(fontSize: 24, color: Colors.white),)),
                  OutlinedButton(onPressed: (){}, child: Text('Friends', style: TextStyle(fontSize: 24, color: Colors.white),))
                ],
              ),
            )
            ],
            ),
            ),
            );
}

