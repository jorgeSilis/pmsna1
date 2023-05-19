import 'dart:async';

import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final List<MapType> tipos = [
    MapType.hybrid,
    MapType.normal,
    MapType.terrain,
    MapType.satellite
  ];
  //int indexMap = 0;
  ValueNotifier<int>indexMap = ValueNotifier<int>(0);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: indexMap,
            builder:(context, value, child) {
              
              return GoogleMap(
                mapType: tipos[value],
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            }
          ),
          CircularMenu(items: [
            CircularMenuItem(
                icon: Icons.home,
                onTap: () => indexMap.value = 0),
            CircularMenuItem(
                icon: Icons.search,
                onTap: () => indexMap.value = 1),
            CircularMenuItem(
                icon: Icons.settings,
                onTap: () => indexMap.value = 2),
          ]),
        ],
      ),
      /*
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),*/
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
