import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutterstanapp/notifier/fund_notifier.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DetailFundView extends StatefulWidget {
  @override
  _DetailFundViewState createState() => _DetailFundViewState();
}

class _DetailFundViewState extends State<DetailFundView> {
  List<charts.Series> seriesList;

  static List<charts.Series<Sales, int>> _createRandomData() {
    final desktopSalesData = [
      Sales(
        0,
        12,
      ),
      Sales(
        1,
        14,
      ),
      Sales(
        2,
        19,
      ),
      Sales(
        3,
        25,
      ),
      Sales(
        4,
        45,
      ),
      Sales(
        5,
        21,
      ),
    ];

    return [
      charts.Series<Sales, int>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.month,
        measureFn: (Sales sales, _) => sales.sales,
        seriesColor: charts.MaterialPalette.white,
        data: desktopSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.white;
        },
        patternColorFn: (Sales sales, _) {
          return charts.MaterialPalette.white;
        },
        areaColorFn: (Sales sales, _) {
          return charts.MaterialPalette.white;
        },
        colorFn: (Sales sales, _) {
          return charts.MaterialPalette.white;
        },
      )
    ];
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }

  lineChart() {
    return charts.LineChart(
      seriesList,
      animate: true,
      domainAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
            // Tick and Label styling here.
            labelStyle: new charts.TextStyleSpec(
                fontSize: 8, // size in Pts.
                color: charts.MaterialPalette.white),
            lineStyle: new charts.LineStyleSpec(
                color: charts.MaterialPalette.transparent)),
      ),
      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.GridlineRendererSpec(
          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
              fontSize: 8, // size in Pts.
              color: charts.MaterialPalette.white),

          // Change the line colors to match text color.
          lineStyle: new charts.LineStyleSpec(
              color: charts.MaterialPalette.transparent),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FundNotifier fundNotifier =
        Provider.of<FundNotifier>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              //Header
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.indigo[400], Colors.indigo[600]]),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(25)),
                    color: Colors.indigo[600],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.14,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(25)),
                        color: Colors.white,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context),
                              color: Colors.indigo[800],
                              alignment: Alignment.topCenter,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    fundNotifier.currentFund.fundTitle,
                                    style: TextStyle(
                                        color: Colors.indigo[800],
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '\$${fundNotifier.currentFund.fundNetAssets}',
                                    style: TextStyle(
                                        color: Colors.indigo[800],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.notifications),
                              onPressed: () {},
                              color: Colors.indigo[800],
                              alignment: Alignment.topLeft,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, bottom: 10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        alignment: Alignment.bottomCenter,
                        child: lineChart(),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            '1Y',
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                fontSize: 10),
                          ),
                          Text(
                            '3Y',
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                fontSize: 10),
                          ),
                          Text(
                            '5Y',
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.indigo[600],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.09,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Fund Value Per Share',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                          fundNotifier.currentFund.fundValPerShare,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.09,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.indigo[600],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Fund Year To Date',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        fundNotifier.currentFund.fundYTD,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.indigo[600],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Fund Year Return',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Spacer(),
                        Text(
                          fundNotifier.currentFund.fundYearReturn,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class Sales {
  int month;
  int sales;

  Sales(this.month, this.sales);
}
