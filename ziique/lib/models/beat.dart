import 'package:cloud_firestore/cloud_firestore.dart';
import 'owner.dart';

class BeatKeys {
  static const id = 'id';
  static const lastEdited = 'lastEdited';
  static const by = 'by';
  static const beatString = 'beatString';
  static const description = 'description';
}

class Beat {
  final String id;
  final DateTime? lastEdited;
  final Owner by;
  final String beatString;
  final String description;

  Beat(
      {required this.id, required this.lastEdited, required this.by, required this.beatString, required this.description});

  Beat.fromMap(this.id, Map<String, dynamic> data)
      : lastEdited = (data[BeatKeys.lastEdited] as Timestamp?)?.toDate(),
        by = Owner.fromMap(data[BeatKeys.by]),
        beatString = data[BeatKeys.beatString],
        description = data[BeatKeys.description];

  Map<String, dynamic> toMap() {
    return {
      BeatKeys.id: id,
      BeatKeys.lastEdited: lastEdited,
      BeatKeys.by: by,
      BeatKeys.beatString: beatString,
      BeatKeys.description: description
    };
  }
}