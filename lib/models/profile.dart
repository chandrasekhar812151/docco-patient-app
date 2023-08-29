class Profile {
  String? phone;
  String? email;
  String? name;
  String? avatar;
  int? age;
  int? weight;
  String? bloodGroup;
  String? gender;

  Profile(
      {this.phone,
      this.email,
      this.name,
      this.avatar,
      this.age,
      this.weight,
      this.bloodGroup,
      this.gender});

  Profile.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    age = json['age'];
    weight = json['weight'];
    bloodGroup = json['blood_group'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['blood_group'] = this.bloodGroup;
    data['gender'] = this.gender;
    return data;
  }
}