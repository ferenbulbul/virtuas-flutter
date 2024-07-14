class User {
  int? id;
  String email;
  String name;
  String surname;
  String phoneNumber;

  User(
      {required this.email,
      required this.name,
      required this.surname,
      required this.phoneNumber,
      this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      name: json['name'],
      surname: json['surname'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
    };
  }
}
