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
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/ZiiQue-Logo.png',
            scale: 12,
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
            )
          ],
          ),
        )
      );
  }
}



