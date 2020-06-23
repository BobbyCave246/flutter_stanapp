import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutterstanapp/models/global_fund_model.dart';

class GFundNotifier with ChangeNotifier {
  List<GlobalFundModel> _gFundList = [];
  GlobalFundModel _gCurrentFund;

  UnmodifiableListView<GlobalFundModel> get gFundList =>
      UnmodifiableListView(_gFundList);

  GlobalFundModel get gCurrentFund => _gCurrentFund;

  set gFundList(List<GlobalFundModel> gFundList) {
    _gFundList = gFundList;
    notifyListeners();
  }

  set gCurrentFund(GlobalFundModel globalFundModel) {
    _gCurrentFund = globalFundModel;
    notifyListeners();
  }
}
