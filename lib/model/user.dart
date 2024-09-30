class User {
  String uid; // Unique identifier for the user (e.g., from Firebase)
  String firstName; // Full name of the user
  String surname;
  String email; // User's email address for authentication
  String phoneNumber; // User's phone number for SMS notifications
  String role; // User role (e.g., Technician, Manager, Admin)
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
    required this.role,
    this.profileImageUrl = '',
    this.department = '',
    this.employeeId = '',
    this.location = '',
  });

  // Factory constructor to create a User object from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      firstName: json['firstName'],
      surname: json['surname'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      profileImageUrl: json['profileImageUrl'] ?? '',
      department: json['department'] ?? '',
      employeeId: json['employeeId'] ?? '',
      location: json['location'] ?? '',
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
      'role': role,
      'profileImageUrl': profileImageUrl,
      'department': department,
      'employeeId': employeeId,
      'location': location,
    };
  }
}
