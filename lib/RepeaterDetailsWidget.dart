import 'package:flutter/material.dart';
import 'repeaters.dart';

class RepeatersDetailsWidget extends StatelessWidget {
  final Repeater repeater;

  RepeatersDetailsWidget({Key key, @required this.repeater}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(repeater.callsign),
        ),
        body: Material(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.settings_input_antenna),
                title: Text('Callsign'),
                trailing: Text(repeater.callsign),
              ),
              ListTile(
                leading: Icon(Icons.my_location),
                title: Text('Location'),
                trailing: Text(repeater.location),
              ),
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Location on map'),
                trailing: Text(repeater.lat + " " + repeater.long),
              ),
              ListTile(
                leading: Icon(Icons.change_history),
                title: Text('Altitude'),
                trailing: Text(repeater.altitude + " m"),
              ),
              ListTile(
                leading: Icon(Icons.chevron_left),
                title: Text('TX'),
                trailing: Text(repeater.out + " MHz"),
              ),
              ListTile(
                leading: Icon(Icons.chevron_right),
                title: Text('RX'),
                trailing: Text(repeater.repeaterIn + " MHz"),
              ),
              ListTile(
                leading: Icon(Icons.location_searching),
                title: Text('QTHR'),
                trailing: Text(repeater.qthr),
              ),
              // ListTile(
              //   leading:
              //       Icon(Icons.signal_cellular_connected_no_internet_4_bar),
              //   title: Text('Status'),
              //   trailing: Text(statusValues.reverseMap[repeater.status]),
              // ),
              // ListTile(
              //   leading: Icon(Icons.developer_mode),
              //   title: Text('Mode'),
              //   trailing: Text(modeValues.reverseMap[repeater.mode]),
              // ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Trustee'),
                trailing: Text(repeater.trustee),
              ),
              ListTile(
                leading: Icon(Icons.phone_in_talk),
                title: Text('Echolink'),
                trailing: Text(repeater.echolink),
              ),
            ],
          ),
        ));
  }
}
