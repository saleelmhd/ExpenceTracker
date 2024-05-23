import 'package:flutter/material.dart';

class NetAmountNotifier extends ChangeNotifier {
  
  double _netAmount = 0;

  double get netAmount => _netAmount;

  set netAmount(double value) {
    _netAmount = value;
    notifyListeners();
  }
}
