import 'package:flutter/material.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart';

class homeProvider extends ChangeNotifier {

  String _loginid = '';
  String _accountType = '';

  TopLevelHome _tLH = TopLevelHome("", "", []);
  Household _houseHold = Household("",{},{});
  List<Household> _houseHolds = [];

  String get loginid => _loginid;
  String get accountType => _accountType;
  TopLevelHome get topLevelHome => _tLH;
  Household get houseHold => _houseHold;
  List<Household> get houseHolds => _houseHolds;
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

  Future<void> fetchData() async {
    User user = await instance.getUserByLogin(loginid);
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
