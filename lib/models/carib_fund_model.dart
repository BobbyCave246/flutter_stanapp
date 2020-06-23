class CaribFundModel {
  String fundTitle;
  String fundPriceDate;
  String fundNetAssets;
  String fundValPerShare;
  String fundYTD;
  String fundYearReturn;
  String fundSubClass;

  CaribFundModel.fromMap(Map<String, dynamic> data) {
    fundTitle = data['fundTitle'];
    fundPriceDate = data['fundPriceDate'];
    fundNetAssets = data['fundNetAssets'];
    fundValPerShare = data['fundValPerShare'];
    fundYTD = data['fundYTD'];
    fundYearReturn = data['fundYearReturn'];
    fundSubClass = data['fundSubClass'];
  }
}
