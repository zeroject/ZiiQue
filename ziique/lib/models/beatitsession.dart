import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user.dart';
import 'package:ziique/models/beat.dart';


class BeatItKeys{
  static const sessionid = "sessionid";
  static const usersadded = "usersadded";
  static const creationTime = "creationTime";
  static const lastModified = "lastModified";
  static const beat = "beat";
  static const timeschanged = "timeschanged";
  static const timesplayed = "timesplayed";
  static const host = "host";
  static const versionid = "versionid";
}


class BeatItSession{
  BeatItSession(this.sessionid,this.usersadded,this.creationTime, this.lastModified, this.beat, this.timeschanged, this.timesplayed, this.host, this.versionid  );
  final String sessionid;
  final List<User> usersadded;
  final DateTime? creationTime;
  final DateTime? lastModified;
  final Beat beat;
  final int timeschanged;
  final int timesplayed;
  final User host;
  final int versionid;

  BeatItSession.fromMap(this.sessionid, Map<String, dynamic> data)
      : usersadded = data[BeatItKeys.usersadded],
        creationTime = (data[BeatItKeys.creationTime] as Timestamp?)?.toDate(),
        lastModified = (data[BeatItKeys.lastModified] as Timestamp?)?.toDate(),
        beat = data[BeatItKeys.beat],
        timeschanged = data[BeatItKeys.timeschanged],
        timesplayed = data[BeatItKeys.timesplayed],
        host = User.fromMap(data[BeatItKeys.host]),
        versionid = data[BeatItKeys.versionid];

  Map<String, dynamic> toMap() {
    return {
      BeatItKeys.sessionid: sessionid,
      BeatItKeys.usersadded: usersadded,
      BeatItKeys.creationTime: creationTime,
      BeatItKeys.lastModified: lastModified,
      BeatItKeys.beat: beat,
      BeatItKeys.timeschanged: timeschanged,
      BeatItKeys.timesplayed: timesplayed,
      BeatItKeys.host: host,
      BeatItKeys.versionid: versionid
    };
}
}
