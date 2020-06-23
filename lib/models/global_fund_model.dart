class GlobalFundModel {
  String fundTitle;
  String fundPriceDate;
  String fundNetAssets;
  String fundValPerShare;
  String fundYTD;
  String fundYearReturn;

  GlobalFundModel.fromMap(Map<String, dynamic> data) {
    fundTitle = data['fundTitle'];
    fundPriceDate = data['fundPriceDate'];
    fundNetAssets = data['fundNetAssets'];
    fundValPerShare = data['fundValPerShare'];
    fundYTD = data['fundYTD'];
    fundYearReturn = data['fundYearReturn'];
  }
}
