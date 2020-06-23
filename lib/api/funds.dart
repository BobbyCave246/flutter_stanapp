import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterstanapp/notifier/global_fund_notifier.dart';
import 'package:flutterstanapp/models/carib_fund_model.dart';
import 'package:flutterstanapp/models/global_fund_model.dart';
import 'package:flutterstanapp/notifier/fund_notifier.dart';

getFunds(FundNotifier fundNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('CaribbeanFunds').getDocuments();

  List<CaribFundModel> _fundList = [];
  snapshot.documents.forEach(
    (document) {
      CaribFundModel caribFundModel = CaribFundModel.fromMap(document.data);
      _fundList.add(caribFundModel);
    },
  );

  fundNotifier.fundList = _fundList;
}

getGFunds(GFundNotifier gFundNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('GlobalFunds').getDocuments();

  List<GlobalFundModel> _gFundList = [];
  snapshot.documents.forEach((document) {
    GlobalFundModel globalFundModel = GlobalFundModel.fromMap(document.data);
    _gFundList.add(globalFundModel);
  });

  gFundNotifier.gFundList = _gFundList;
}
