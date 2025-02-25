class HomeOwner{
  
  String id ="";
  String email = "";
  String firstname = "";
  String surname = "";
  bool hasGoogleLogin = false;
  String password = "";
  String phoneNumber = "";
  String topHouseId = "";

  HomeOwner(this.id, this.firstname, this.surname, this.email, this.password, this.phoneNumber, this.topHouseId, this.hasGoogleLogin);
  
  HomeOwner.basic(this.firstname, this.surname);

}