class HomeOwner{
  
  String id ="";
  String email = "";
  String firstname = "";
  String surname = "";
  bool hasGoogleLogin = false;
  String encryptedPassword = "";
  String phoneNumber ="";
  String topHouseholdDocumentId = "";

  HomeOwner(this.id, this.firstname, this.surname, this.email, this.encryptedPassword, this.phoneNumber, this.topHouseholdDocumentId, this.hasGoogleLogin);
  
  HomeOwner.basic(this.firstname, this.surname);

  
}