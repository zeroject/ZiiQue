class UserKeys {
  static const uid = 'uid';
  static const firstname = 'firstname';
  static const lastname = 'lastname';
  static const friends = 'friends';
  static const inSession = 'inSession';
  static const sessionID = 'sessionID';
}

class User {
  final String uid;
  final String firstname;
  final String lastname;
  final List<String> friends;
  bool inSession = false;
  String sessionID = "";

  User({required this.uid, required this.firstname, required this.lastname, required this.friends});

  User.fromMap(Map<String, dynamic> data)
      : uid = data[UserKeys.uid],
        firstname = data[UserKeys.firstname],
        lastname = data[UserKeys.lastname],
        inSession = data[UserKeys.inSession],
        sessionID = data[UserKeys.sessionID],
        friends = (data[UserKeys.friends] as List<dynamic>).map((e) => e.toString(),).toList();

   toMap() {
    return {
      UserKeys.uid: uid,
      UserKeys.firstname: firstname,
      UserKeys.lastname: lastname,
      UserKeys.inSession: inSession,
      UserKeys.sessionID: sessionID,
      UserKeys.friends: friends
    };
  }
}