import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


String friendcode = '1234';

const snackBar = SnackBar(content: Text('Code has been copied!'));

class FriendsSettingsPage extends StatelessWidget {
    FriendsSettingsPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (kIsWeb) {
            return BuildDesktop(context);
          } else if(Platform.isAndroid){
            return BuildMobile(context);
          };
          return BuildDesktop(context);
        }
    ),
    );
  }
}

Widget BuildMobile(BuildContext context){
  return Scaffold(

  );
}

Widget BuildDesktop(BuildContext context){
  return Scaffold(

  );
}