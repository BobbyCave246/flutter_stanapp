import 'package:flutter/material.dart';
import 'package:flutterstanapp/notifier/fund_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutterstanapp/service/database_service.dart';
import 'home_widget.dart';
import 'notifier/global_fund_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final firestoreService = FirebaseService();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => FundNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => GFundNotifier(),
      ),
      StreamProvider(
        create: (context) => firestoreService.getSubFunds(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fund App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}
