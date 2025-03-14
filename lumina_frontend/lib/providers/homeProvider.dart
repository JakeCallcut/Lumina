import 'package:flutter/material.dart';

class homeProvider extends ChangeNotifier {
  Future<void> fetchData() async {
    // Add your data fetching logic here
    notifyListeners();
  }
}
