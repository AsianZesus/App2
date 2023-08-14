import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController _mapController = MapController();
  List<Marker> markers = [];

  final dbRef = FirebaseDatabase.instance.ref().child('HC');
  final dbRefTwo = FirebaseDatabase.instance.ref().child('YF');

  @override
  void initState() {
    super.initState();
    // Add static markers
    _addStaticMarkers();
  }

  void _addStaticMarkers() {
    // Define your list of locations with coordinates and texts
    List<Map<String, dynamic>> locations = [
      {
        'latitude': 27.70790343888775,
        'longitude': 85.32596595639622,
        'text': 'Marker 1',
      },
      // Add more locations as needed
    ];

    // Loop through the list and create markers
    for (var location in locations) {
      double latitude = location['latitude'];
      double longitude = location['longitude'];
      String text = location['text'];

      // Create a marker and add it to the markers list
      markers.add(_createMarker(LatLng(latitude, longitude), text));
    }
  }

  // Helper method to create a marker with text
  Marker _createMarker(LatLng point, String text) {
    bool isCardVisible = false;

    return Marker(
      width: 80.0,
      height: 80.0,
      point: point,
      builder: (ctx) => GestureDetector(
        onTap: () {
          setState(() {
            isCardVisible = !isCardVisible;
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40.0,
            ),
            if (isCardVisible) _buildMarkerCard(text),
          ],
        ),
      ),
    );
  }

  Widget _buildMarkerCard(String text) {
    return Container(
      width: 120,
      height: 60,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController, // Assign the map controller
      options: MapOptions(
        center: LatLng(27.7076878362209, 85.32487877305384),
        zoom: 18,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: markers,
        ),
      ],
    );
  }
}
