class UserModel {
  final int id;
  final String userId;
  final String name;
  final String email;
  final String created;
  final String userInformationStatus;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String token;

  UserModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.created,
    required this.userInformationStatus,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      userId: json['user']['user_id'],
      name: json['user']['name'],
      email: json['user']['email'],
      created: json['user']['created'],
      userInformationStatus: json['user']['userInformationStatus'],
      status: json['user']['status'],
      createdAt: json['user']['created_at'],
      updatedAt: json['user']['updated_at'],
      token: json['token'],
    );
  }
}
