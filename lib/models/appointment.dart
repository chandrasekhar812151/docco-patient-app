class Appointment {
  int? id;
  String? type;
  String? issue;
  String? doctorName;
  String? doctorTitle;
  int? doctorId;
  String? prescriptionImage;
  String? status;
  String? doctorPicture;
  String? fromTime;
  String? toTime;
  String? symptoms;
  String? deliveryStatus;
  String? deliveryAddress;
  List<String>? medicalReports;

  Appointment(
      {this.id,
      this.type,
      this.issue,
      this.doctorName,
      this.doctorTitle,
      this.doctorId,
      this.prescriptionImage,
      this.status,
      this.doctorPicture,
      this.fromTime,
      this.toTime,
      this.symptoms,
      this.deliveryStatus,
      this.deliveryAddress,
      this.medicalReports});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    issue = json['issue'];
    doctorName = json['doctor_name'];
    doctorTitle = json['doctor_title'];
    doctorId = json['doctor_id'];
    prescriptionImage = json['prescription_image'];
    status = json['status'];
    doctorPicture = json['doctor_picture'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    symptoms = json['symptoms'];
    deliveryStatus = json['delivery_status'];
    deliveryAddress = json['delivery_address'];
    medicalReports = json['medical_reports'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['issue'] = this.issue;
    data['doctor_name'] = this.doctorName;
    data['doctor_title'] = this.doctorTitle;
    data['doctor_id'] = this.doctorId;
    data['prescription_image'] = this.prescriptionImage;
    data['status'] = this.status;
    data['doctor_picture'] = this.doctorPicture;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['symptoms'] = this.symptoms;
    data['delivery_status'] = this.deliveryStatus;
    data['delivery_address'] = this.deliveryAddress;
    data['medical_reports'] = this.medicalReports;
    return data;
  }
}