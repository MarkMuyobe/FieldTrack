class ServiceRequest {
  String id;
  String clientName;
  String description;
  String category;
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
    required this.clientName,
    required this.description,
    required this.category,
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
      id: json['id'],
      clientName: json['clientName'],
      description: json['description'],
      category: json['category'],
      dateCreated: DateTime.parse(json['dateCreated']),
      status: json['status'],
      technicianId: json['technicianId'],
      gpsLocation: json['gpsLocation'],
      images: List<String>.from(json['images']),
      notes: json['notes'],
      scheduledDate: DateTime.parse(json['scheduledDate']),
      timeCompleted: json['timeCompleted'] != null
          ? DateTime.parse(json['timeCompleted'])
          : null,
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