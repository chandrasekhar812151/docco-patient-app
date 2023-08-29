class Doctor {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? title;
  String? overview;
  String? gender;
  int? fee;
  int? fee_in_dollars;
  int? addressId;
  int? rating;
  int? showRating;
  String? avatar;
  Address? address;
  List<Education>? education;
  List<Specializations>? specializations;
  List<Languages>? languages;
  List<Services>? services;
  List<Experience>? experience;
  List<Memberships>? memberships;
  List<Awards>? awards;

  Doctor(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.title,
      this.overview,
      this.gender,
      this.fee,
      this.fee_in_dollars,
      this.addressId,
      this.rating,
      this.showRating,
      this.avatar,
      this.address,
      this.education,
      this.specializations,
      this.languages,
      this.services,
      this.experience,
      this.memberships,
      this.awards});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    title = json['title'];
    overview = json['overview'];
    gender = json['gender'];
    fee = json['fee'];
    fee_in_dollars = json['fee_in_dollars'];
    addressId = json['address_id'];
    rating = json['rating'];
    showRating = json['show_rating'];
    avatar = json['avatar'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['education'] != null) {
      education = Education() as List<Education>;
      json['education'].forEach((v) {
        education?.add(new Education.fromJson(v));
      });
    }
    if (json['specializations'] != null) {
      specializations = Specializations() as List<Specializations>?;
      json['specializations'].forEach((v) {
        specializations?.add(new Specializations.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = Languages() as List<Languages>;
      json['languages'].forEach((v) {
        languages?.add(new Languages.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = Services() as List<Services>;
      json['services'].forEach((v) {
        services?.add(new Services.fromJson(v));
      });
    }
    if (json['experience'] != null) {
      experience = Experience() as List<Experience>;
      json['experience'].forEach((v) {
        experience?.add(new Experience.fromJson(v));
      });
    }
    if (json['memberships'] != null) {
      memberships = Memberships() as List<Memberships>;
      json['memberships'].forEach((v) {
        memberships?.add(new Memberships.fromJson(v));
      });
    }
    if (json['awards'] != null) {
      awards = Awards() as List<Awards>;
      json['awards'].forEach((v) {
        awards?.add(new Awards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['title'] = this.title;
    data['overview'] = this.overview;
    data['gender'] = this.gender;
    data['fee'] = this.fee;
    data['fee_in_dollars'] = this.fee_in_dollars;
    data['address_id'] = this.addressId;
    data['rating'] = this.rating;
    data['show_rating'] = this.showRating;
    data['avatar'] = this.avatar;
    if (this.address != null) {
      data['address'] = this.address?.toJson();
    }
    if (this.education != null) {
      data['education'] = this.education?.map((v) => v.toJson()).toList();
    }
    if (this.specializations != null) {
      data['specializations'] =
          this.specializations?.map((v) => v.toJson()).toList();
    }
    if (this.languages != null) {
      data['languages'] = this.languages?.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services?.map((v) => v.toJson()).toList();
    }
    if (this.experience != null) {
      data['experience'] = this.experience?.map((v) => v.toJson()).toList();
    }
    if (this.memberships != null) {
      data['memberships'] = this.memberships?.map((v) => v.toJson()).toList();
    }
    if (this.awards != null) {
      data['awards'] = this.awards?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  int? id;
  String? plotNo;
  String? street;
  String? city;
  String? postalCode;
  String? country;
  String? countryIsoCode;

  Address(
      {this.id,
      this.plotNo,
      this.street,
      this.city,
      this.postalCode,
      this.country,
      this.countryIsoCode});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plotNo = json['plot_no'];
    street = json['street'];
    city = json['city'];
    postalCode = json['postal_code'];
    country = json['country'];
    countryIsoCode = json['country_iso_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plot_no'] = this.plotNo;
    data['street'] = this.street;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['country'] = this.country;
    data['country_iso_code'] = this.countryIsoCode;
    return data;
  }
}

class Education {
  int? id;
  int? doctorId;
  String? degreeLevel;
  String? specialization;
  String? institution;

  Education(
      {this.id,
      this.doctorId,
      this.degreeLevel,
      this.specialization,
      this.institution});

  Education.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    degreeLevel = json['degree_level'];
    specialization = json['specialization'];
    institution = json['institution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['degree_level'] = this.degreeLevel;
    data['specialization'] = this.specialization;
    data['institution'] = this.institution;
    return data;
  }
}

class Specializations {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Specializations(
      {this.id, this.name, this.createdAt, this.updatedAt, this.pivot});

  Specializations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot?.toJson();
    }
    return data;
  }
}

class Pivot {
  int? doctorId;
  int? specializationId;

  Pivot({this.doctorId, this.specializationId});

  Pivot.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    specializationId = json['specialization_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['specialization_id'] = this.specializationId;
    return data;
  }
}

class Languages {
  int? id;
  int? doctorId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Languages(
      {this.id, this.doctorId, this.name, this.createdAt, this.updatedAt});

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Services {
  int? id;
  int? doctorId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Services({this.id, this.doctorId, this.name, this.createdAt, this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Experience {
  int? id;
  int? doctorId;
  String? description;
  String? createdAt;
  String? updatedAt;

  Experience(
      {this.id,
      this.doctorId,
      this.description,
      this.createdAt,
      this.updatedAt});

  Experience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Memberships {
  int? id;
  int? doctorId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Memberships(
      {this.id, this.doctorId, this.name, this.createdAt, this.updatedAt});

  Memberships.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Awards {
  int? id;
  int? doctorId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Awards({this.id, this.doctorId, this.name, this.createdAt, this.updatedAt});

  Awards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}