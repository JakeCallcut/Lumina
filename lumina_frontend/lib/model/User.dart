class User {
  
  String id = "";
  String loginId = "";
  String firstname = "";
  String surname = "";
  bool hasGoogleLogin = false;
  String phoneNumber = "";
  String houseCodeId = "";

  User(this.id, this.loginId, this.firstname, this.surname, this.phoneNumber, this.houseCodeId, this.hasGoogleLogin);
  
  User.basic(this.firstname, this.surname);

}