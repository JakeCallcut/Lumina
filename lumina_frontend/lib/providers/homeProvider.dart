import 'package:flutter/material.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart';

class homeProvider extends ChangeNotifier {

  String _loginid = '';
  String _accountType = '';

  String get loginid => _loginid;
  String get accountType => _accountType;

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
    TopLevelHome TLH = await instance.getTopLevelHome(user.houseCodeId);
    if (TLH.id != "") {
      setAccountType("manager");
    } else {
    }
    notifyListeners();
  }
}
