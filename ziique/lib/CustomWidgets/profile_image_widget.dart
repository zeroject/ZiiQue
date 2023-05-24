import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ziique/FireService/Storage-Files/fire_image_service.dart';
import 'package:ziique/FireService/fire_user_service.dart';
import 'package:ziique/Settings/settings_widget.dart';
import 'package:ziique/models/user.dart' as beat_user;

class ProfileImage extends StatefulWidget{
  ProfileImage({
    super.key, 
    required this.imgUrl
  });

  String imgUrl;
  
  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {

  void pickUploadImage() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75
    );
    
    await ImageService().storeProfileImage(image!).then((value) {
      UserService().updateUser(beat_user.User(
        uid: beatuser!.uid, 
        firstname: beatuser!.firstname, 
        lastname: beatuser!.lastname, 
        friends: beatuser!.friends, 
        profileImgUrl: value
      ));
      setState(() {
        widget.imgUrl = value;
      });
    });
    
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pickUploadImage();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: 120,
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: widget.imgUrl == "" ? Colors.blueAccent : Colors.blueAccent.withOpacity(0), 
          border: const Border(
            top: BorderSide(color: Colors.blueAccent, width: 5),
            right: BorderSide(color: Colors.blueAccent, width: 5),
            bottom: BorderSide(color: Colors.blueAccent, width: 5),
            left: BorderSide(color: Colors.blueAccent, width: 5)
          )),
        child: Center(
          child: widget.imgUrl == "" ? const Icon(
            Icons.person, size: 80, color: Colors.white,
          ) : Image.network(widget.imgUrl),
        ),
      ),
    );
  }
}