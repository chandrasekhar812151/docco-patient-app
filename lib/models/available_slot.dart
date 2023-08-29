class AvailableSlot {
  int? id;
  String? fromTime;
  String? toTime;

  AvailableSlot({this.id, this.fromTime, this.toTime});

  AvailableSlot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    return data;
  }
}