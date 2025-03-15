import 'package:flutter/material.dart';

class HCProvider extends ChangeNotifier {
  String _homeCode = '';
  String _managerHomeCode = '';

  String get homeCode => _homeCode;
  String get managerHomeCode => _managerHomeCode;

  void setHCID(String name) {
    _homeCode = name;
    notifyListeners(); // Notify widgets listening to this provider
  }
  void setMHCID(String name) {
    _managerHomeCode = name;
    notifyListeners(); // Notify widgets listening to this provider
  }
}