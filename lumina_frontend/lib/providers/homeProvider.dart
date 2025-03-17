import 'package:flutter/material.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart';

class homeProvider extends ChangeNotifier {

  static String uid = '';

  void setUid(String dynamicUid) {
    uid = dynamicUid;
  }

  Future<void> fetchData() async {
    // Add your data fetching logic here
    var instance = Integration();
    User user = await instance.getUser(uid);
    print(user.firstname);
    print(user.houseCodeId);
    notifyListeners();
  }
}
