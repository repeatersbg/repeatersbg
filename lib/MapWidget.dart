import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'LocalDataManager.dart';
import 'repeaters.dart';
import 'package:geolocator/geolocator.dart';
import 'RepeatersListWidget.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Repeaters.BG"),
      ),
      body: MapsScreen(),
      floatingActionButton: FloatingActionButton(
        elevation: 32.0,
        child: Icon(Icons.settings_input_antenna),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: 'Repeaters'))),
      ),
    );
  }
}

class MapsScreen extends StatefulWidget {
  @override
  State createState() => MapsScreenState();
}

class MapsScreenState extends State<MapsScreen> {
  GoogleMapController mapController;
  final screenData = MediaQueryData.fromWindow(ui.window);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(0.0),
        child: Center(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Container(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(42.11, 25.00)
                ),
            ),
          ),
        ));
  }

  void _add(LatLng latLng, String title, String details, double hue) {
    mapController.addMarker(MarkerOptions(
        position: latLng,
        infoWindowText: InfoWindowText(title, details),
        icon: BitmapDescriptor.defaultMarkerWithHue(hue)));
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    if (LocalDataManager.repeaters != null) {
      _loadRepeaters(LocalDataManager.repeaters);
    } else {
      LocalDataManager.reloadRepeaters().then((RepeatersList repeatersList) {
        _loadRepeaters(repeatersList);
      });
      controller.onInfoWindowTapped.add(_showData);
    }

    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0.0,
        target: LatLng(position.latitude, position.longitude),
        tilt: 0.0,
        zoom: 9.0,
      )));
    });
  }

  void _loadRepeaters(RepeatersList repeatersList) {
    setState(() {
      for (var repeater in repeatersList.repeaters) {
        var lat = double.tryParse(repeater.lat);
        var lon = double.tryParse(repeater.long);
        if (lat != null && lon != null) {
          final latLng =
              LatLng(double.parse(repeater.lat), double.parse(repeater.long));
          double hue = 0.0;
          switch (repeater.mode) {
            case Mode.ANALOG:
              hue = repeater.band == Band.THE_70_CM
                  ? BitmapDescriptor.hueAzure
                  : BitmapDescriptor.hueCyan;
              break;
            case Mode.DSTAR:
              hue = BitmapDescriptor.hueViolet;
              break;
          }
          _add(latLng, repeater.callsign + ' [' + repeater.out + ']',
              repeater.location, hue);
        }
      }
    });
  }

  void _showData(Marker marker) {
    print(marker.options.infoWindowText.title);
  }
}
