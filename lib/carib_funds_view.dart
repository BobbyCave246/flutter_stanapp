import 'package:flutterstanapp/api/funds.dart';
import 'package:flutterstanapp/constants/colors.dart';
import 'package:flutterstanapp/notifier/fund_notifier.dart';
import 'package:flutterstanapp/views/test_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CaribbeanFundsView extends StatefulWidget {
  @override
  _CaribbeanFundsViewState createState() => _CaribbeanFundsViewState();
}

class _CaribbeanFundsViewState extends State<CaribbeanFundsView> {
  @override
  void initState() {
    FundNotifier fundNotifier =
        Provider.of<FundNotifier>(context, listen: false);
    getFunds(fundNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FundNotifier fundNotifier = Provider.of<FundNotifier>(context);
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image(
                image: AssetImage('assets/fortress_Name.png'),
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          child: new ListView.builder(
            itemCount: fundNotifier.fundList.length,
            itemBuilder: (BuildContext context, int index) => new Container(
              child: Card(
                color: navBarColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                margin: EdgeInsets.only(left: 20, bottom: 5),
                child: InkWell(
                  onTap: () {
                    fundNotifier.currentFund = fundNotifier.fundList[index];
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return TestView();
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: cardColor,
                            ),
                            child: Icon(
                              Icons.bookmark,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      fundNotifier.fundList[index].fundTitle,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: cardFundTextColor),
                                    ),
                                  ),
                                  Text(
                                    'Latest Price Date - ${fundNotifier.fundList[index].fundPriceDate}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
