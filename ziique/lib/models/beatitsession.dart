

class BeatItKeys {
  static const sessionid = "sessionid";
  static const usersadded = "usersadded";
  static const creationTime = "creationTime";
  static const lastModified = "lastModified";
  static const beatString = "beatString";
  static const timeschanged = "timeschanged";
  static const timesplayed = "timesplayed";
  static const hostID = "hostID";
  static const versionid = "versionid";
}

class BeatItSession {
  BeatItSession({
      required this.sessionid,
      required this.usersadded,
      required this.creationTime,
      required this.lastModified,
      required this.beatString,
      required this.timeschanged,
      required this.timesplayed,
      required this.hostID,
      required this.versionid});

  final String sessionid;
  final Map<String, String> usersadded;
  final String creationTime;
  final String lastModified;
  final String beatString;
  final int timeschanged;
  final int timesplayed;
  final String hostID;
  final int versionid;

  BeatItSession.fromMap(this.sessionid, Map<String, dynamic> data)
      : usersadded = data[BeatItKeys.usersadded],
        creationTime = data[BeatItKeys.creationTime],
        lastModified = data[BeatItKeys.lastModified],
        beatString = data[BeatItKeys.beatString],
        timeschanged = data[BeatItKeys.timeschanged],
        timesplayed = data[BeatItKeys.timesplayed],
        hostID = data[BeatItKeys.hostID],
        versionid = data[BeatItKeys.versionid];

  Map<String, dynamic> toMap() {
    return {
      BeatItKeys.sessionid: sessionid,
      BeatItKeys.usersadded: usersadded,
      BeatItKeys.creationTime: creationTime,
      BeatItKeys.lastModified: lastModified,
      BeatItKeys.beatString: beatString,
      BeatItKeys.timeschanged: timeschanged,
      BeatItKeys.timesplayed: timesplayed,
      BeatItKeys.hostID: hostID,
      BeatItKeys.versionid: versionid
    };
  }
}
