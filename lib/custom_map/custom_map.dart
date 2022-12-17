import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({super.key});

  @override
  State<CustomMap> createState() => _MyAppState();
}

class _MyAppState extends State<CustomMap> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_pin),
          onPressed: () {
            mapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    zoom: 20,
                    target: LatLng(31.768323779634553, 35.21335758268833))));
          }),
      appBar: AppBar(
        title: const Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        markers: markers,
        onTap: (LatLng x) {
          log(x.toString());
          // markers.add(Marker(
          //     markerId: MarkerId('jerusalem+${x.latitude}'), position: x));
          // setState(() {});
        },
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(31.768323779634553, 35.21335758268833),
          zoom: 10.0,
        ),
      ),
    );
  }
}
