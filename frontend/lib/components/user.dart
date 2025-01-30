class User {
  final String id;
  final String name;
  final String email;
  final String imageUrl; // Assuming you also have an image URL for each user.
  final String lastMessage;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.imageUrl,
      required this.lastMessage});

  // Method to convert JSON to User object.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'].toString(),
        name: json['name'],
        email: json['email'],
        imageUrl: json['imageUrl'], // Modify according to your API response.
        lastMessage: json['lastMessage']);
  }
}
