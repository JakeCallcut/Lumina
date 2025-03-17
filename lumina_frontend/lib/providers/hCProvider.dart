import 'package:flutter/material.dart';

class HCProvider extends ChangeNotifier {
  String _managerHomeCode = '';

  String get managerHomeCode => _managerHomeCode;

  void setMHCID(String name) {
    _managerHomeCode = name;
    notifyListeners(); // Notify widgets listening to this provider
  }
}