class UserKeys {
  static const uid = 'uid';
  static const firstname = 'firstname';
  static const lastname = 'lastname';
  static const birthday = 'birthday';
  static const friends = 'friends';
}

class User {
  final String uid;
  final String firstname;
  final String lastname;
  final DateTime? birthday;
  final List<String> friends;

  User({required this.uid, required this.firstname, required this.lastname, required this.birthday, required this.friends});

  User.fromMap(Map<String, dynamic> data)
      : uid = data[UserKeys.uid],
        firstname = data[UserKeys.firstname],
        lastname = data[UserKeys.lastname],
        birthday = data[UserKeys.birthday],
        friends = data[UserKeys.friends];

   toMap() {
    return {
      UserKeys.uid: uid,
      UserKeys.firstname: firstname,
      UserKeys.lastname: lastname,
      UserKeys.birthday: birthday,
      UserKeys.friends: friends
    };
  }
}