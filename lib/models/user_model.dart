class User {
  const User({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
  });
  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'] as String,
        address: json['address'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String,
        website: json['website'] as String,
      );
  final String name;
  final String address;
  final String phone;
  final String email;
  final String website;
}
