class Worker {
  final String? uid;
  final String name;
  final String? phoneNo;
  final String city;
  String onGoing;
  final List<dynamic> domain;

  Worker({
    required this.uid,
    required this.name,
    required this.phoneNo,
    required this.city,
    required this.domain,
    this.onGoing = "NA",
  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      uid: json['uid'],
      name: json['name'],
      phoneNo: json['phoneNo'],
      city: json['city'],
      domain: json['domain'], 
      onGoing: json['on_going'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'phoneNo': phoneNo,
      'city': city,
      'domain': domain,
      'on_going': onGoing,
    };
  }

  Map<String, dynamic> toJsonD() {
    return {
      'uid': uid,
      'name': name,
      'phoneNo': phoneNo,
      'city': city,
      'domain': domain,
    };
  }

}