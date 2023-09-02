import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fire/Utils/app_space.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Constants/app_strings.dart';
import '../Widgets/kAppBar.dart';

class HomePageMapView extends StatefulWidget {
  const HomePageMapView({super.key});

  @override
  State<HomePageMapView> createState() => _HomePageMapViewState();
}

class _HomePageMapViewState extends State<HomePageMapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

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
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            Positioned(
              top: MediaQuery.paddingOf(context).top + 10,
              left: 0,
              right: 0,
              child: kAppBar(
                size: size,
                title: AppStrings.appName,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 150,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {},
          child: SizedBox(
            width: 200,
            child: Row(
              children: [
                AppSpace.spaceW10,
                Icon(
                  Icons.location_pin,
                ),
                AppSpace.spaceW10,
                Text("My Location"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
