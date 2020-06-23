import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterstanapp/animations/carib_no_anim.dart';
import 'package:flutterstanapp/constants/colors.dart';
import 'package:flutterstanapp/notifier/fund_notifier.dart';
import 'package:flutterstanapp/views/consolidator_view.dart';
import 'package:flutterstanapp/views/high_interest_fund_view.dart';
import 'package:flutterstanapp/views/test_view.dart';
import 'package:provider/provider.dart';

class CapitalSecureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FundNotifier fundNotifier =
        Provider.of<FundNotifier>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection("CaribbeanFunds")
                  .document('UPvqtWpU6oZM2tA15Dlq')
                  .collection('Capital Secure Share')
                  .document('Capital Secure Share')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading');
                }
                var firestoreData = snapshot.data;
                return backgroundContainer(context, firestoreData);
              }),
          StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection("CaribbeanFunds")
                  .document('UPvqtWpU6oZM2tA15Dlq')
                  .collection('Capital Secure Share')
                  .document('Capital Secure Share')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading');
                }
                var firestoreData = snapshot.data;
                return foregroundContainer(context, firestoreData);
              }),
        ],
      ),
    );
  }

  Align foregroundContainer(BuildContext context, fundNotifier) {
    FundNotifier fundNotifier =
        Provider.of<FundNotifier>(context, listen: false);
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

  Widget backgroundContainer(
      BuildContext context, DocumentSnapshot firestoreData) {
    FundNotifier fundNotifier =
        Provider.of<FundNotifier>(context, listen: false);
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
                  onPressed: () => Navigator.popUntil(
                    context,
                    ModalRoute.withName('/'),
                  ),
                  color: Colors.white,
                ),
              ),
              Text(
                firestoreData['fundTitle'],
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () => Navigator.pop(context),
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
                    '\$${firestoreData['fundNetAssets']}',
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
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        new MyCustomRoute(builder: (context) => new TestView()),
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
                          'Aggressive Accumulator',
                          style: TextStyle(color: navBarColor, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        new MyCustomRoute(
                            builder: (context) => new ConsolidatorView()),
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
                          style: TextStyle(color: navBarColor, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Capital Secure',
                          style: TextStyle(color: navBarColor, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
