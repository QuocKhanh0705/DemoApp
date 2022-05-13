class Contact {
  final int id;
  final String name;
  final String dob;
  final String phone;
  final String email;
  final String address;
  final String description;
  final String note;

  const Contact({
    required this.id,
    required this.name,
    required this.dob,
    required this.phone,
    required this.email,
    required this.address,
    required this.description,
    required this.note,
  });


  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['Id'] as int,
      name: json['p0'] as String,
      phone: json['p1'] as String,
      email: json['p2'] as String,
      address: json['p3'] as String,
      description: json['p4'] as String,
      dob: json['p5'] as String,
      note: json['p6'] as String,
    );
  }
}
