class UserModel {
  final String name;
  final String profilePic;
  final String uid;
  final String email;


  UserModel({
    required this.name,
    required this.profilePic,
    required this.email,
    required this.uid,

  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? email,
    String? uid,

  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      email: email ?? this.email,
      uid: uid ?? this.uid,

    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'email': email,
      'uid': uid,

    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',

    );
  }
}
