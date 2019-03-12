import 'package:flutter/material.dart';
import 'repeaters.dart';
import 'MapWidget.dart' as MapWidget;
import 'LocalDataManager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RepeaterDetailsWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RepeatersBG',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MapWidget.SecondScreen(),
    );
  }
}
