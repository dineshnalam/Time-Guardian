class Contractor {
  final String? uid;
  final String name;
  final String? phoneNo;
  final String city;

  Contractor({
    required this.uid,
    required this.name,
    required this.phoneNo,
    required this.city,
  });

  factory Contractor.fromJson(Map<String, dynamic> json) {
    return Contractor(
      uid: json['uid'],
      name: json['name'],
      phoneNo: json['phoneNo'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'phoneNo': phoneNo,
      'city': city,
    };
  }
}