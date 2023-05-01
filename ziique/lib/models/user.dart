class UserKeys {
  static const uid = 'uid';
  static const displayName = 'displayName';
  static const email = 'email';
  static const profileImage = 'profileImage';
}

class User {
  final String uid;
  final String displayName;
  final String email;
  final String profileImage;

  User({required this.uid, required this.displayName, required this.email, required this.profileImage});

  User.fromMap(Map<String, dynamic> data)
      : uid = data[UserKeys.uid],
        displayName = data[UserKeys.displayName],
        email = data[UserKeys.email],
        profileImage = data[UserKeys.profileImage];

  toMap() {
    return {
      UserKeys.uid: uid,
      UserKeys.displayName: displayName,
      UserKeys.email: email,
      UserKeys.profileImage : profileImage
    };
  }
}