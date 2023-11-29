import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Controller/map_controller.dart';

class MapCustomView extends StatelessWidget {
  const MapCustomView({
    super.key,
    required this.size,
  });
  
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var controller = ref.watch(mapProvider);
        return SizedBox(
          height: size.height,
          width: size.width,
          child: GoogleMap(
            mapType: MapType.values[4],
            trafficEnabled: true,
            mapToolbarEnabled: true,
            myLocationButtonEnabled: false,
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
    );
  }
}
