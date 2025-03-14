import 'package:flutter/material.dart';

class HHProvider extends ChangeNotifier {
  String _hHID = '';

  String get hHID => _hHID;

  void sethHName(String id) {
    _hHID = id;
    notifyListeners(); // Notify widgets listening to this provider
  }
}