import 'package:flutter/material.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart';

class TLHProvider extends ChangeNotifier {
  String _tlhName = '';

  String get tlhName => _tlhName;

  void setTLHName(String name) {
    _tlhName = name;
    notifyListeners(); // Notify widgets listening to this provider
  }
}