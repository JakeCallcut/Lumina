import 'package:flutter/material.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart';

class homeProvider extends ChangeNotifier {

  String _loginid = '';
  String _accountType = '';

  TopLevelHome _tLH = TopLevelHome("", "", []);
  Household _household = Household("",{},{});
  List<Household> _households = [];

  String get loginid => _loginid;
  String get accountType => _accountType;
  TopLevelHome get topLevelHome => _tLH;
  Household get household => _household;
  List<Household> get households => _households;

  void setUid(String dynamicUid) {
    _loginid = dynamicUid;
  }

  void setAccountType(String account) {
    _accountType = account;
  }

  Future<void> fetchData() async {
    // Add your data fetching logic here
    var instance = Integration();
    User user = await instance.getUserByLogin(loginid);
    TopLevelHome tLH = await instance.getTopLevelHome(user.houseCodeId);
    if (tLH.id != "") {
      setAccountType("manager");
      managerData(user, tLH);
      _tLH = tLH;
    } else {
      residentData(user);
    }
    notifyListeners();
  }

  Future<void> managerData(user, tLH) async {
    List<Household> tempHouseholds = await Integration().getHouseholds(tLH.id);
    _households = tempHouseholds;
  }

  Future<void> residentData(user) async {
    
  }
}
