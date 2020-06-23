import 'package:flutterstanapp/api/funds.dart';
import 'package:provider/provider.dart';
import 'package:flutterstanapp/constants/colors.dart';
import 'global_detail_fund_view.dart';
import 'package:flutter/material.dart';
import 'notifier/global_fund_notifier.dart';

class GlobalFundsView extends StatefulWidget {
  @override
  _GlobalFundsViewState createState() => _GlobalFundsViewState();
}

class _GlobalFundsViewState extends State<GlobalFundsView> {
  @override
  void initState() {
    GFundNotifier gFundNotifier =
        Provider.of<GFundNotifier>(context, listen: false);
    getGFunds(gFundNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GFundNotifier gFundNotifier = Provider.of<GFundNotifier>(context);
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
            itemCount: gFundNotifier.gFundList.length,
            itemBuilder: (BuildContext context, int index) => new Container(
              child: Card(
                color: navBarColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                ),
                margin: EdgeInsets.only(left: 20, bottom: 5),
                child: InkWell(
                  onTap: () {
                    gFundNotifier.gCurrentFund = gFundNotifier.gFundList[index];
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return GlobalDetailFundView();
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                                    gFundNotifier.gFundList[index].fundTitle,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: cardFundTextColor),
                                  ),
                                ),
                                Text(
                                  'Latest Price Date - ${gFundNotifier.gFundList[index].fundPriceDate}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
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
      ],
    );
  }
}
