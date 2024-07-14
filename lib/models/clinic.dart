class Clinic {
  final int id;
  final String title;
  final String description;
  final String address;
  final String webAddress;
  int credit;

  Clinic(
      {required this.id,
      required this.title,
      required this.description,
      required this.address,
      required this.webAddress,
      required this.credit});

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        address: json['address'],
        webAddress: json['webAddress'],
        credit: json['credit']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'address': address,
        'webAddress': webAddress,
        'credit': credit
      };
}
