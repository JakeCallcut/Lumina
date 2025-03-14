import 'package:flutter/material.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';

class homeProvider extends ChangeNotifier {

  static String uid = '';

  static void setUid(String dynamicUid) {
    uid = dynamicUid;
  }

  Future<void> fetchData() async {
    // Add your data fetching logic here
    var instance = Integration();
    print(uid);
    notifyListeners();
  }
}
