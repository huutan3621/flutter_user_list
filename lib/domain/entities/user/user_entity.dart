class UserEntity {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  bool isFavorite;

  UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
      'isFavorite': isFavorite ? 1 : 0, // Store boolean as integer
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      avatar: map['avatar'],
      isFavorite: map['isFavorite'] == 1, // Convert integer to boolean
    );
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, firstName: $firstName, lastName: $lastName, avatar: $avatar, isFavorite: $isFavorite)';
  }
}
