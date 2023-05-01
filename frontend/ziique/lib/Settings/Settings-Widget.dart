import 'package:flutter/material.dart';

class SettingsPageDesktop extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class SettingsPageMobile extends StatelessWidget {
    SettingsPageMobile(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Page')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/grey-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: null,
      ),
    );
  }
}



