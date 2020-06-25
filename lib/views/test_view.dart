import 'package:flutter/material.dart';
import 'package:flutterstanapp/animations/carib_no_anim.dart';
import 'package:flutterstanapp/constants/colors.dart';
import 'consolidator_view.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutterstanapp/models/sales_model.dart';
import 'package:flutterstanapp/notifier/fund_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutterstanapp/views/high_interest_fund_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'capital_secure_view.dart';

class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  List<charts.Series> seriesList;

  static List<charts.Series<Sales, int>> _createRandomData() {
    final desktopSalesData = [
      Sales(
        1,
        12,
      ),
      Sales(
        2,
        14,
      ),
      Sales(
        3,
        19,
      ),
      Sales(
        4,
        25,
      ),
      Sales(
        5,
        45,
      ),
      Sales(
        6,
        21,
      ),
      Sales(
        7,
        22,
      ),
      Sales(
        8,
        24,
      ),
      Sales(
        9,
        18,
      ),
      Sales(
        10,
        29,
      ),
      Sales(
        11,
        34,
      ),
      Sales(
        12,
        36,
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
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }

  lineChart() {
    return charts.LineChart(
      seriesList,
      animate: true,
      animationDuration: Duration.zero,
      domainAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
              fontSize: 8, // size in Pts.
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
            fontSize: 8, // size in Pts.
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
    FundNotifier fundNotifier =
        Provider.of<FundNotifier>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          backgroundContainer(context, fundNotifier),
          foregroundContainer(context, fundNotifier),
        ],
      ),
    );
  }

  Align foregroundContainer(BuildContext context, fundNotifier) {
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
                    ),
                    Spacer(),
                    Text(
                      fundNotifier.currentFund.fundPriceDate,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
            fundGraph(context),
            fundNavWidget(context, fundNotifier),
          ],
        ),
      ),
    );
  }

  Container fundGraph(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: lineChart(),
    );
  }

  Expanded fundNavWidget(BuildContext context, fundNotifier) {
    FundNotifier fundNotifier =
        Provider.of<FundNotifier>(context, listen: false);
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
                  navBarColor,
                  navBarColor,
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
                        fundNotifier.currentFund.fundValPerShare,
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
                        '${fundNotifier.currentFund.fundYTD}\%',
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
                        '${fundNotifier.currentFund.fundYearReturn}\%',
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

  Container backgroundContainer(BuildContext context, fundNotifier) {
    FundNotifier fundNotifier =
        Provider.of<FundNotifier>(context, listen: false);
    var chif = fundNotifier.currentFund.fundTitle;
    var cpf = 'Caribbean Pension Fund';
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: navBarColor,
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.popAndPushNamed(context, '/'),
                  color: Colors.white,
                ),
              ),
              Text(
                fundNotifier.currentFund.fundTitle,
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications),
                  color: Colors.white,
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
                    '\$${fundNotifier.currentFund.fundNetAssets}',
                    style: TextStyle(
                        letterSpacing: 3,
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
            child: ConditionalSwitch.single<String>(
              context: context,
              valueBuilder: (BuildContext context) => '$chif',
              caseBuilders: {
                'Caribbean High Interest Fund': (BuildContext context) =>
                    high_Interest_Buttons(context),
                'Caribbean Pension Fund': (BuildContext context) => FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Aggressive Accumulator',
                                  style: TextStyle(
                                      color: navBarColor, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                new MyCustomRoute(
                                    builder: (context) =>
                                        new ConsolidatorView()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Conservative Consolidator',
                                  style: TextStyle(
                                      color: navBarColor, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                new MyCustomRoute(
                                    builder: (context) =>
                                        new CapitalSecureView()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Capital Secure',
                                  style: TextStyle(
                                      color: navBarColor, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              },
              fallbackBuilder: (BuildContext context) => SizedBox(
                height: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row high_Interest_Buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Accumulation Share',
                style: TextStyle(color: navBarColor),
              ),
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              new MyCustomRoute(
                  builder: (context) => new HighInterestFundView()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Distribution Share',
                style: TextStyle(color: navBarColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
