class User {
  
  String id = "";
  String loginId = "";
  String firstname = "";
  String surname = "";
  bool hasGoogleLogin = false;
  String phoneNumber = "";
  String topHouseId = "";
  String householdId = "";

  User(this.id, this.loginId, this.firstname, this.surname, this.phoneNumber, this.topHouseId, this.householdId, this.hasGoogleLogin);
  
  User.basic(this.firstname, this.surname);

}