import 'package:cloud_firestore/cloud_firestore.dart';
import 'owner.dart';

class BeatKeys {
  static const id = 'id';
  static const title = 'title';
  static const lastEdited = 'lastEdited';
  static const by = 'by';
  static const beatString = 'beatString';
  static const description = 'description';
  static const publicity = 'publicity';
}

class Beat {
  final String id;
  final String title;
  final DateTime? lastEdited;
  final Owner by;
  final String beatString;
  final String description;
  final String publicity;

  Beat(
    {required this.id, required this.title, this.lastEdited, required this.by, required this.beatString, required this.description, required this.publicity});

  Beat.fromMap(this.id, Map<String, dynamic> data)
      : title = data[BeatKeys.title],
        lastEdited = (data[BeatKeys.lastEdited] as Timestamp?)?.toDate(),
        by = Owner.fromMap(data[BeatKeys.by]),
        beatString = data[BeatKeys.beatString],
        description = data[BeatKeys.description],
        publicity = data[BeatKeys.publicity];

  Map<String, dynamic> toMap() {
    return {
      BeatKeys.id: id,
      BeatKeys.title: title,
      BeatKeys.lastEdited: lastEdited,
      BeatKeys.by: by,
      BeatKeys.beatString: beatString,
      BeatKeys.description: description,
      BeatKeys.publicity: publicity
    };
  }
}