class User {
  final String? userEmail;
  final String? userPw;
  final String? userName;

  User({required this.userEmail, required this.userPw, required this.userName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userEmail: json['nickname'],
      userPw: json['userPw'],
      userName: json['userName'],
    );
  }
  Map<String, dynamic> toJson() => {
        'userEmail': userEmail,
        'userPw': userPw,
        'userName': userName,
      };
}
