class EnergyUsage {

  String id = "";
  String topHouseId = "";
  String householdId = "";
  int unused = 0;
  int worth = 0;
  int amount = 0;
  int price = 0;
  Map<String, int> monthEnergyIn = {};
  Map<String, int> monthEnergyOut = {};

  EnergyUsage(this.id, this.topHouseId, this.householdId, this.unused, this.worth, this.amount, this.price, this.monthEnergyIn, this.monthEnergyOut);
}