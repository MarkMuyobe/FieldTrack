enum UserRole {
  user,
  technician,
  manager,
  admin
}

class User {
  String uid; // Unique identifier for the user (e.g., from Firebase)
  String firstName; // Full name of the user
  String surname;
  String email; // User's email address for authentication
  String phoneNumber; // User's phone number for SMS notifications
  UserRole role; // User role (e.g., Technician, Manager, Admin)
  String profileImageUrl; // URL to the user's profile picture (optional)
  String department; // The department the user works in (optional)
  String employeeId; // Optional employee ID for organizational purposes
  String location; // Current GPS location of the user (optional)


  // Constructor
  User({
    required this.uid,
    required this.firstName,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    this.role = UserRole.user,
    this.profileImageUrl = '',
    this.department = '',
    this.employeeId = '',
    this.location = '',
  });

  // Factory constructor to create a User object from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      role: _parseUserRole(json['role']),
    );
  }

  // Method to convert the User object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'surname': surname,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role.toString().split('.').last,
      'profileImageUrl': profileImageUrl,
      'department': department,
      'employeeId': employeeId,
      'location': location,
    };
  }

  static UserRole _parseUserRole(dynamic roleValue) {
    if (roleValue is String) {
      try {
        return UserRole.values.firstWhere(
          (e) => e.toString().split('.').last.toLowerCase() == roleValue.toLowerCase(),
        );
      } catch (_) {
        // If the role string doesn't match any enum value, default to user
        return UserRole.user;
      }
    }
    // If roleValue is not a String or is null, default to user
    return UserRole.user;
  }

  User copyWith({
    String? uid,
    String? firstName,
    String? surname,
    String? email,
    String? phoneNumber,
    UserRole? role,
    String? profileImageUrl,
    String? department,
    String? employeeId,
    String? location,
  }) {
    return User(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      department: department ?? this.department,
      employeeId: employeeId ?? this.employeeId,
      location: location ?? this.location,
    );
  }
}
