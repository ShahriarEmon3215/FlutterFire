import 'package:flutter/material.dart';
import 'package:flutter_fire/Controller/map_controller.dart';
import 'package:flutter_fire/Utils/app_space.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../Constants/app_strings.dart';
import '../../Widgets/kAppBar.dart';

class HomePageMapView extends StatefulWidget {
  const HomePageMapView({super.key});

  @override
  State<HomePageMapView> createState() => _HomePageMapViewState();
}

class _HomePageMapViewState extends State<HomePageMapView> {
  MapController? controller;

  @override
  void initState() {
    super.initState();
// make sure to initialize before map loading
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(5, 5)), 'assets/markers/man.png')
        .then((d) {
      controller!.customIcon = d;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    controller = Provider.of<MapController>(context, listen: false);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Consumer<MapController>(
              builder: (context, controller, child) {
                return Container(
                  height: size.height,
                  width: size.width,
                  child: GoogleMap(
                    mapType: MapType.hybrid,
                    trafficEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    markers: controller.getMarkers(),
                    initialCameraPosition: controller.myCurrentLocation,
                    onMapCreated: (GoogleMapController googleMapController) {
                      controller.gMapController.complete(googleMapController);
                    },
                    onTap: (points) {
                      controller.handleTap(points, context);
                    },
                  ),
                );
              },
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
            Positioned(
              bottom: 10,
              left: 20,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller!.getCurrentLocation();
                    },
                    child: Icon(Icons.location_pin),
                  ),
                  AppSpace.spaceW10,
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text("Send Alert".toUpperCase()),
                        AppSpace.spaceW10,
                        Icon(Icons.send)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
