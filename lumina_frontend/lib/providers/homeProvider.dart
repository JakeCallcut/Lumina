import 'package:flutter/material.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart';

class homeProvider extends ChangeNotifier {

  String _loginid = '';
  String _accountType = '';

  TopLevelHome _tLH = TopLevelHome("", "", []);
  Household _houseHold = Household("",{},{});
  List<Household> _houseHolds = [];
  User _user = User("","","","","","",false);
  List<EnergyUsage> _energyUsage = [];

  String get loginid => _loginid;
  String get accountType => _accountType;
  User get user => _user;
  TopLevelHome get topLevelHome => _tLH;
  Household get houseHold => _houseHold;
  List<Household> get houseHolds => _houseHolds;
  List<EnergyUsage> get energyUsage => _energyUsage;
  var instance = Integration();
  // List of rooms
  // list of devices
  // list of energy

  void setUid(String dynamicUid) {
    _loginid = dynamicUid;
  }

  void setAccountType(String account) {
    _accountType = account;
  }

  void setEnergyUsage(EnergyUsage energy) {
    _energyUsage[0] = energy;
  }

  Future<void> fetchData() async {
    User user = await instance.getUserByLogin(loginid);
    _user = user;
    TopLevelHome tLH = await instance.getTopLevelHome(user.houseCodeId);
    if (tLH.id != "") {
      setAccountType("manager");
      _tLH = tLH;
      await managerData(user);
    } else {
      await residentData(user);
    }
    notifyListeners();
  }

  Future<void> managerData(user) async {
    List<Household> tempHouseholds = await instance.getHouseholds(_tLH.id);
    _houseHolds = tempHouseholds;
  }

  Future<void> residentData(user) async {
    
  }
}
