class DoctorSearchResult {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? title;
  String? gender;
  int? fee;
  String? avatar;
  String? category;

  DoctorSearchResult(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.title,
      this.gender,
      this.fee,
      this.avatar,
      this.category});

  DoctorSearchResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    title = json['title'];
    gender = json['gender'];
    fee = json['fee'];
    avatar = json['avatar'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['title'] = this.title;
    data['gender'] = this.gender;
    data['fee'] = this.fee;
    data['avatar'] = this.avatar;
    data['category'] = this.category;
    return data;
  }
}