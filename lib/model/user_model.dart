class UserModel {
  final String name;
  final String profilePic;
  final String uid;
  final String email;
  final String mobileNumber;
  final String countryCode;
  final int otp;
  final DateTime otpUpdate;


  UserModel({
    required this.name,
    required this.profilePic,
    required this.email,
    required this.uid,
    required this.mobileNumber,
    required this.countryCode,
    required this.otp,
    required this.otpUpdate,

  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? email,
    String? uid,
    String? mobileNumber,
    String? countryCode,
    int? otp,
    DateTime? otpUpdate,

  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      countryCode: countryCode ?? this.countryCode,
      otp: otp ?? this.otp,
      otpUpdate: otpUpdate ?? this.otpUpdate,

    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'email': email,
      'uid': uid,
      'mobileNumber': mobileNumber,
      'countryCode': countryCode,
      'otp': otp,
      'otpUpdate': otpUpdate,

    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      countryCode: map['countryCode'] ?? '',
      otp: map['otp'] ?? '',
      otpUpdate: map['otpUpdate'] ?? '',

    );
  }
}
