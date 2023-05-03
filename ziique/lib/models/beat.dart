import 'package:cloud_firestore/cloud_firestore.dart';
import 'owner.dart';

class BeatKeys {
  static const id = 'id';
  static const lastEdited = 'lastEdited';
  static const from = 'from';
  static const beatString = 'beatString';
  static const description = 'description';
}

class Beat {
  final String id;
  final DateTime? lastEdited;
  final Owner from;
  final String beatString;
  final String description;

  Beat(
      {required this.id, required this.lastEdited, required this.from, required this.beatString, required this.description});

  Beat.fromMap(this.id, Map<String, dynamic> data)
      : lastEdited = (data[BeatKeys.lastEdited] as Timestamp?)?.toDate(),
        from = Owner.fromMap(data[BeatKeys.from]),
        beatString = data[BeatKeys.beatString],
        description = data[BeatKeys.description];

  Map<String, dynamic> toMap() {
    return {
      BeatKeys.id: id,
      BeatKeys.lastEdited: lastEdited,
      BeatKeys.from: from,
      BeatKeys.beatString: beatString,
      BeatKeys.description: description
    };
  }
}