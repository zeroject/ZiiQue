import '../../models/user.dart';
import 'package:ziique/models/beat.dart';

class BeatItSession{
  BeatItSession(this.sessionid,this.usersadded,this.creationTime, this.lastModified, this.beat, this.timeschanged, this.timesplayed, this.host, this.versionid  );
  String sessionid;
  List<User> usersadded;
  DateTime creationTime;
  DateTime lastModified;
  Beat beat;
  int timeschanged;
  int timesplayed;
  User host;
  int versionid;
}
