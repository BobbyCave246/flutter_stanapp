import 'package:flutter/material.dart';
import 'package:flutterstanapp/models/sales_model.dart';
import 'package:provider/provider.dart';
import 'package:flutterstanapp/views/high_interest_fund_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'notifier/global_fund_notifier.dart';

class GlobalDetailFundView extends StatefulWidget {
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
      Sales(
        5,
        21,
      ),
      Sales(
        6,
        21,
      ),
      Sales(
        7,
        21,
      ),
      Sales(
        8,
        21,
      ),
      Sales(
        9,
        21,
      ),
    ];

    return [
      charts.Series<Sales, int>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.month,
        measureFn: (Sales sales, _) => sales.sales,
        seriesColor: charts.Color.fromHex(code: '#4B0082'),
        data: desktopSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.Color.fromHex(code: '#4B0082');
        },
        patternColorFn: (Sales sales, _) {
          return charts.Color.fromHex(code: '#4B0082');
        },
        areaColorFn: (Sales sales, _) {
          return charts.Color.fromHex(code: '#4B0082');
        },
        colorFn: (Sales sales, _) {
          return charts.Color.fromHex(code: '#4B0082');
        },
      )
    ];
  }

  @override
  _GlobalDetailFundViewState createState() => _GlobalDetailFundViewState();
}

class _GlobalDetailFundViewState extends State<GlobalDetailFundView> {
  List<charts.Series> seriesList;

  @override
  void initState() {
    super.initState();
    seriesList = GlobalDetailFundView._createRandomData();
  }

  lineChart() {
    return charts.LineChart(
      seriesList,
      animate: true,
      domainAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
              fontSize: 10, // size in Pts.
              color: charts.Color.fromHex(code: '#4B0082')),
          lineStyle: new charts.LineStyleSpec(
            color: charts.Color.fromHex(code: '#4B0082'),
          ),
        ),
      ),
      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.GridlineRendererSpec(
          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
            fontSize: 10, // size in Pts.
            color: charts.Color.fromHex(code: '#4B0082'),
          ),

          // Change the line colors to match text color.
          lineStyle: new charts.LineStyleSpec(
              color: charts.MaterialPalette.transparent),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    GFundNotifier gFundNotifier =
        Provider.of<GFundNotifier>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          backgroundContainer(context, gFundNotifier),
          foregroundContainer(context, gFundNotifier),
        ],
      ),
    );
  }

  Align foregroundContainer(BuildContext context, gFundNotifier) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Fund Performance',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.indigo[600]),
                    ),
                    Spacer(),
                    Text(
                      gFundNotifier.gCurrentFund.fundPriceDate,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.indigo),
                    ),
                  ],
                ),
              ),
            ),
            fundGraph(context),
            fundNavWidget(context, gFundNotifier),
          ],
        ),
      ),
    );
  }

  Container fundGraph(BuildContext context) {
    return Container(
      child: lineChart(),
      color: Colors.white,
      height: 200,
      width: MediaQuery.of(context).size.width,
    );
  }

  Expanded fundNavWidget(BuildContext context, gFundNotifier) {
    GFundNotifier gFundNotifier =
        Provider.of<GFundNotifier>(context, listen: false);
    return Expanded(
      child: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.indigo,
                  Colors.indigo[600],
                ],
              ),
            ),
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Fund NAV Per Share',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        gFundNotifier.gCurrentFund.fundValPerShare,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Fund Year To Date Return',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${gFundNotifier.gCurrentFund.fundYTD}\%',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Fund 1 Year Return',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${gFundNotifier.gCurrentFund.fundYearReturn}\%',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container backgroundContainer(BuildContext context, gFundNotifier) {
    GFundNotifier gFundNotifier =
        Provider.of<GFundNotifier>(context, listen: false);
    var chif = gFundNotifier.gCurrentFund.fundTitle;
    var cpf = 'Caribbean Pension Fund';
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.indigo[600],
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.white,
                ),
              ),
              FittedBox(
                child: Text(
                  gFundNotifier.gCurrentFund.fundTitle,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: IconButton(
                  icon: Icon(Icons.notifications),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$${gFundNotifier.gCurrentFund.fundNetAssets}',
                    style: TextStyle(
                        letterSpacing: 3,
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      'CGF',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
