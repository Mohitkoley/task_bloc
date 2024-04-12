class UserModel {
  final String name;
  final int phoneNumber;
  final String photoUrl;
  final String city;
  final double rupee;

  UserModel(
      {required this.name,
      required this.phoneNumber,
      required this.photoUrl,
      required this.city,
      required this.rupee});

  UserModel copyWith({
    String? name,
    int? phoneNumber,
    String? photoUrl,
    String? city,
    double? rupee,
  }) {
    return UserModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      city: city ?? this.city,
      rupee: rupee ?? this.rupee,
    );
  }

  bool get isHigh => rupee > 50;
}
