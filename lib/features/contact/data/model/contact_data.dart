class ContactData {
  final int? id;
  final String name;
  final String phone;
  final String image;

  ContactData(
      {this.id, required this.name, required this.phone, required this.image});

  factory ContactData.fromJson(Map<String, dynamic> json) {
    return ContactData(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'image': image,
    };
  }
}
