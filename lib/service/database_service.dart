import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterstanapp/models/carib_fund_model.dart';

class FirebaseService {
  Firestore _db = Firestore.instance;
  Stream<List<CaribFundModel>> getSubFunds() {
    return _db.collection('CaribbeanFunds').snapshots().map((snapshot) =>
        snapshot.documents
            .map((document) => CaribFundModel.fromMap(document.data))
            .toList());
  }
}
