class Household {

  String id = "";
  Map<String, String> homeDetails = {}; //address:string, inviteCode:int
  Map<String, dynamic> settings = {}; //notifications:bool, budget:num, darkmode:bool

  Household(this.id, this.homeDetails, this.settings);
}