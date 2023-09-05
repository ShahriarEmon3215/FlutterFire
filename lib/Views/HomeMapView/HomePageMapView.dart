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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = Provider.of<MapController>(context, listen: false);
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
                    initialCameraPosition: controller.myCurrentLocation,
                    onMapCreated: (GoogleMapController googleMapController) {
                      controller.gMapController.complete(googleMapController);
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 150,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {
            controller.getCurrentLocation();
          },
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
