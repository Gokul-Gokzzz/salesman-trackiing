class UserRegistrationModel {
  // final String id;
  final String name;
  final String email;
  final int mobileNumber;
  final String password;
  final String accountProvider;

  UserRegistrationModel({
    required this.name,
    // required this.id,
    required this.email,
    required this.mobileNumber,
    required this.password,
    required this.accountProvider,
  });

  Map<String, dynamic> toJson() {
    return {
      // "id":id,
      "name": name,
      "email": email,
      "mobileNumber": mobileNumber,
      "password": password,
      "accountProvider": accountProvider,
    };
  }
}
