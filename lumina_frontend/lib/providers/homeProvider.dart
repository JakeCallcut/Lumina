import 'package:flutter/material.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart';

class homeProvider extends ChangeNotifier {

  String _loginid = '';

  String get loginid => _loginid;

  void setUid(String dynamicUid) {
    _loginid = dynamicUid;
  }

  Future<void> fetchData() async {
    // Add your data fetching logic here
    var instance = Integration();
    print("Login id: $loginid");
    User user = await instance.getUserByLogin(loginid);
    print("User firstname: ${user.firstname}, User lastname: ${user.surname}");
    print("User housecode: ${user.houseCodeId}");
    notifyListeners();
  }
}
