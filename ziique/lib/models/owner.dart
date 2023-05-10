class OwnerKeys {
  static const uid = 'uid';
  static const displayName = 'displayName';
  static const email = 'email';
}

class Owner {
  final String? uid;
  final String displayName;
  final String email;

  Owner({required this.uid, required this.displayName, required this.email});

  Owner.fromMap(Map<String, dynamic> data)
      : uid = data[OwnerKeys.uid],
        displayName = data[OwnerKeys.displayName],
        email = data[OwnerKeys.email];

   toMap() {
    return {
      OwnerKeys.uid: uid,
      OwnerKeys.displayName: displayName,
      OwnerKeys.email: email
    };
  }
}