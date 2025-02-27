class Household {

  String id = "";
  String name = "";
  Map<String, String> homeDetails = {}; //address:string, inviteCode:int
  Map<String, dynamic> settings = {}; //notifications:bool, budget:num, darkmode:bool

  Household(this.id, this.name, this.homeDetails, this.settings);
}