class RegisterDataModel {
  final String name;
  final String mobileNo;
  final String emailId;
  final String password;
  String? id;
  String? createdAt;
  String? updatedAt;

  RegisterDataModel(
      {required this.name,
      required this.mobileNo,
      required this.emailId,
      required this.password,
      this.id,
      this.createdAt,
      this.updatedAt});

  factory RegisterDataModel.fromJson(Map<String, dynamic> json) =>
      RegisterDataModel(
          name: json['name'],
          mobileNo: json['mobileNo'],
          emailId: json['emailId'],
          password: json['password']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'mobileNo': mobileNo,
        'emailId': emailId,
        'password': password,
      };
}
