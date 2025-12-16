class Account {
  final String id, email, name;
  final String? cvDetails, location, phoneNumber, gitHub, linkedIn, role;
  Account({
    required this.id,
    required this.email,
    required this.name,
    this.cvDetails,
    this.location,
    this.phoneNumber,
    this.gitHub,
    this.linkedIn,
    this.role,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      cvDetails: json['cvDetails'] as String?,
      location: json['location'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      gitHub: json['gitHub'] as String?,
      linkedIn: json['linkedIn'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'cvDetails': cvDetails,
      'location': location,
      'phoneNumber': phoneNumber,
      'gitHub': gitHub,
      'linkedIn': linkedIn,
      'role': role,
    };
  }

  //copy with method
  Account copyWith({
    String? id,
    String? email,
    String? name,
    String? cvDetails,
    String? location,
    String? phoneNumber,
    String? gitHub,
    String? linkedIn,
    String? role,
  }) {
    return Account(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      cvDetails: cvDetails ?? this.cvDetails,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gitHub: gitHub ?? this.gitHub,
      linkedIn: linkedIn ?? this.linkedIn,
      role: role ?? this.role,
    );
  }
}
