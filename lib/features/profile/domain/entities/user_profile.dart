class UserProfile {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String token;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.token,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'photoUrl': photoUrl, 'token': token};
  }

  UserProfile copyWith({String? id, String? name, String? email, String? photoUrl, String? token}) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      token: token ?? this.token,
    );
  }
}
