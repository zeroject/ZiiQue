import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

class MessageKeys {
  static const lastEdited = 'lastEdited';
  static const from = 'from';
  static const beatString = 'beatString';
}

class Message {
  final String id;
  final DateTime? lastEdited;
  final User from;
  final String beatString;

  Message(
      {required this.id,
      required this.lastEdited,
      required this.from,
      required this.beatString});

  Message.fromMap(this.id, Map<String, dynamic> data)
      : lastEdited = (data[MessageKeys.lastEdited] as Timestamp?)?.toDate(),
        from = User.fromMap(data[MessageKeys.from]),
        beatString = data[MessageKeys.beatString];

  Map<String, dynamic> toMap() {
    return {
      MessageKeys.lastEdited: lastEdited,
      MessageKeys.from: from,
      MessageKeys.beatString: beatString
    };
  }
}