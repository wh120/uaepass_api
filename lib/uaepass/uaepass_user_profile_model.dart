class UAEPASSUserProfile {
  String? sub;
  String? fullNameAR;
  String? gender;
  String? mobile;
  String? lastnameEN;
  String? fullNameEN;
  String? uuid;
  String? lastnameAR;
  String? idn;
  String? nationalityEN;
  String? firstnameEN;
  String? userType;
  String? nationalityAR;
  String? firstnameAR;
  String? email;

  UAEPASSUserProfile(
      {this.sub,
      this.fullNameAR,
      this.gender,
      this.mobile,
      this.lastnameEN,
      this.fullNameEN,
      this.uuid,
      this.lastnameAR,
      this.idn,
      this.nationalityEN,
      this.firstnameEN,
      this.userType,
      this.nationalityAR,
      this.firstnameAR,
      this.email});

  UAEPASSUserProfile.fromJson(Map<String, dynamic> json) {
    sub = json['sub'];
    fullNameAR = json['fullnameAR'];
    gender = json['gender'];
    mobile = json['mobile'];
    lastnameEN = json['lastnameEN'];
    fullNameEN = json['fullnameEN'];
    uuid = json['uuid'];
    lastnameAR = json['lastnameAR'];
    idn = json['idn'];
    nationalityEN = json['nationalityEN'];
    firstnameEN = json['firstnameEN'];
    userType = json['userType'];
    nationalityAR = json['nationalityAR'];
    firstnameAR = json['firstnameAR'];
    email = json['email'];
  }
}
