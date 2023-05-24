import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ziique/models/fire_user.dart';

class ImageService{
  Future<String> storeProfileImage(XFile image) async {
    if (kIsWeb){
      Reference ref = FirebaseStorage.instance.ref().child("profilePictures/${FirebaseAuth.instance.currentUser!.uid}/profilePic");
      UploadTask uploadTask = ref.putData(await image.readAsBytes(), SettableMetadata(contentType: "image/jpeg"));
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;

    }else if (!kIsWeb){
      Reference ref = FirebaseStorage.instance.ref().child("profilePictures/${FirebaseAuth.instance.currentUser!.uid}/profilePic");
      await ref.putFile(File(image.path));

      ref.getDownloadURL().then((value) {
        return value;
      });
    }
    return "";
  }
}