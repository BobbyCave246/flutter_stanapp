import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutterstanapp/models/carib_fund_model.dart';

class FundNotifier with ChangeNotifier {
  List<CaribFundModel> _fundList = [];
  CaribFundModel _currentFund;

  UnmodifiableListView<CaribFundModel> get fundList =>
      UnmodifiableListView(_fundList);

  CaribFundModel get currentFund => _currentFund;

  set fundList(List<CaribFundModel> fundList) {
    _fundList = fundList;
    notifyListeners();
  }

  set currentFund(CaribFundModel fundModel) {
    _currentFund = fundModel;
    notifyListeners();
  }
}
