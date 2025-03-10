class DetailedMeetingModel {
  final String? id;
  final String? title;
  final DetailedMeetingSalesman? salesman;
  final DetailedMeetingClient? client;
  final DateTime? dateTime;
  final String? locationType;
  final String? locationDetails;
  final DetailedMeetingFieldStaff? fieldStaff;
  final String? agenda;
  final String? notes;
  final String? attachment;
  final String? repeatFrequency;
  final DateTime? followUpReminder;

  DetailedMeetingModel({
    this.id,
    this.title,
    this.salesman,
    this.client,
    this.dateTime,
    this.locationType,
    this.locationDetails,
    this.fieldStaff,
    this.agenda,
    this.notes,
    this.attachment,
    this.repeatFrequency,
    this.followUpReminder,
  });

  factory DetailedMeetingModel.fromJson(Map<String, dynamic> json) {
    return DetailedMeetingModel(
      id: json["_id"] as String?,
      title: json["title"] as String?,
      salesman: json["salesman"] != null
          ? DetailedMeetingSalesman.fromJson(json["salesman"])
          : null,
      client: json["client"] != null
          ? DetailedMeetingClient.fromJson(json["client"])
          : null,
      dateTime:
          json["dateTime"] != null ? DateTime.tryParse(json["dateTime"]) : null,
      locationType: json["locationType"] as String?,
      locationDetails: json["locationDetails"] as String?,
      fieldStaff: json["fieldStaff"] != null
          ? DetailedMeetingFieldStaff.fromJson(json["fieldStaff"])
          : null,
      agenda: json["agenda"] as String?,
      notes: json["notes"] as String?,
      attachment: json["attachment"] as String?,
      repeatFrequency: json["repeatFrequency"] as String?,
      followUpReminder: json["followUpReminder"] != null
          ? DateTime.tryParse(json["followUpReminder"])
          : null,
    );
  }
}

class DetailedMeetingSalesman {
  final String? id;
  final String? name;
  final String? email;
  final String? mobileNumber;
  final int? points;

  DetailedMeetingSalesman({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.points,
  });

  factory DetailedMeetingSalesman.fromJson(Map<String, dynamic> json) {
    return DetailedMeetingSalesman(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      email: json["email"] as String?,
      mobileNumber: json["mobileNumber"]?.toString(),
      points: json["points"] as int?,
    );
  }
}

class DetailedMeetingClient {
  final String? id;
  final String? name;
  final String? companyName;
  final String? email;
  final String? contact;
  final String? address;
  final int? outstandingDue;
  final int? ordersPlaced;

  DetailedMeetingClient({
    this.id,
    this.name,
    this.companyName,
    this.email,
    this.contact,
    this.address,
    this.outstandingDue,
    this.ordersPlaced,
  });

  factory DetailedMeetingClient.fromJson(Map<String, dynamic> json) {
    return DetailedMeetingClient(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      companyName: json["companyName"] as String?,
      email: json["email"] as String?,
      contact: json["contact"] as String?,
      address: json["address"] as String?,
      outstandingDue: json["outstandingDue"] as int?,
      ordersPlaced: json["ordersPlaced"] as int?,
    );
  }
}

class DetailedMeetingFieldStaff {
  final String? id;
  final String? name;
  final String? location;
  final String? email;
  final String? contact;

  DetailedMeetingFieldStaff({
    this.id,
    this.name,
    this.location,
    this.email,
    this.contact,
  });

  factory DetailedMeetingFieldStaff.fromJson(Map<String, dynamic> json) {
    return DetailedMeetingFieldStaff(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      location: json["location"] as String?,
      email: json["email"] as String?,
      contact: json["contact"] as String?,
    );
  }
}
