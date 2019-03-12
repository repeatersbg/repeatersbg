import 'package:flutter/material.dart';
import 'repeaters.dart';
import 'MapWidget.dart' as MapWidget;
import 'LocalDataManager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RepeaterDetailsWidget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RepeatersList repeatersList;
  List<Widget> tableView = <Widget>[];

  void showMap() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MapWidget.SecondScreen()));
  }

  void reloadList() {
    LocalDataManager.reloadRepeaters().then((RepeatersList list) {
    setState(() {
        repeatersList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    reloadList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(context),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: showMap,
      //   tooltip: 'Map',
      //   child: Icon(Icons.map),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildBody(BuildContext context) {
    if (repeatersList != null) {
      return _buildList(context, repeatersList.repeaters);
    } else {
      return Center();
    }
  }

  Widget _buildList(BuildContext context, List<Repeater> repeaters) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: repeaters
          .map((repeater) => _buildListItem(context, repeater))
          .toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Repeater repeater) {
    return Padding(
      key: ValueKey(repeater.callsign),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(repeater.callsign),
          trailing: Text(repeater.repeaterIn + " MHz"),
          subtitle: Text(repeater.location),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RepeatersDetailsWidget(repeater: repeater))),
          onLongPress: () => _launchMaps(repeater),
        ),
      ),
    );
  }

  void _launchMaps(Repeater repeater) async {
  String googleUrl =
    'comgooglemaps://?center=${repeater.lat},${repeater.long}&zoom=14&views=traffic&q=${repeater.lat},${repeater.long}';
  String appleUrl =
    'https://maps.apple.com/?sll=${repeater.lat},${repeater.long}&zoom=14&views=traffic&q=${repeater.lat},${repeater.long}';
  if (await canLaunch("comgooglemaps://")) {
    print('launching com googleUrl');
    await launch(googleUrl);
  } else if (await canLaunch(appleUrl)) {
    print('launching apple url');
    await launch(appleUrl);
  } else {
    throw 'Could not launch url';
  }
}
}
