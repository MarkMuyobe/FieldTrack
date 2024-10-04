class ServiceRequest {
  String id;
  String clientName;  // Keep this as clientName
  String description;
  String category;    // Keep this as category
  DateTime dateCreated;
  String status;
  String technicianId;
  String gpsLocation;
  List<String> images;
  String notes;
  DateTime scheduledDate;
  DateTime? timeCompleted;

  ServiceRequest({
    required this.id,
    required this.clientName,  // Keep this as clientName
    required this.description,
    required this.category,    // Keep this as category
    required this.dateCreated,
    required this.status,
    required this.technicianId,
    required this.gpsLocation,
    required this.images,
    required this.notes,
    required this.scheduledDate,
    this.timeCompleted
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      id: json['id'] as String? ?? '',
      clientName: json['clientName'] as String? ?? '',  // Keep this as clientName
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',      // Keep this as category
      dateCreated: DateTime.tryParse(json['dateCreated'] as String? ?? '') ?? DateTime.now(),
      status: json['status'] as String? ?? '',
      technicianId: json['technicianId'] as String? ?? '',
      gpsLocation: json['gpsLocation'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      notes: json['notes'] as String? ?? '',
      scheduledDate: DateTime.tryParse(json['scheduledDate'] as String? ?? '') ?? DateTime.now(),
      timeCompleted: json['timeCompleted'] != null ? DateTime.tryParse(json['timeCompleted'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'description': description,
      'category': category,
      'dateCreated': dateCreated.toIso8601String(),
      'status': status,
      'technicianId': technicianId,
      'gpsLocation': gpsLocation,
      'images': images,
      'notes': notes,
      'scheduledDate': scheduledDate.toIso8601String(),
      'timeCompleted': timeCompleted?.toIso8601String(),
    };
  }

}