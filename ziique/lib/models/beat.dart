import 'package:cloud_firestore/cloud_firestore.dart';
import 'owner.dart';

class BeatKeys {
  static const lastEdited = 'lastEdited';
  static const from = 'from';
  static const beatString = 'beatString';
}

class Beat {
  final String id;
  final DateTime? lastEdited;
  final Owner from;
  final String beatString;

  Beat(
      {required this.id,
      required this.lastEdited,
      required this.from,
      required this.beatString});

  Beat.fromMap(this.id, Map<String, dynamic> data)
      : lastEdited = (data[BeatKeys.lastEdited] as Timestamp?)?.toDate(),
        from = Owner.fromMap(data[BeatKeys.from]),
        beatString = data[BeatKeys.beatString];

  Map<String, dynamic> toMap() {
    return {
      BeatKeys.lastEdited: lastEdited,
      BeatKeys.from: from,
      BeatKeys.beatString: beatString
    };
  }
}