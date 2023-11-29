import 'package:flutter/material.dart';
import 'package:flutter_fire/Controller/map_controller.dart';
import 'package:flutter_fire/Utils/app_space.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Constants/app_strings.dart';
import '../../Widgets/kAppBar.dart';

class HomePageMapView extends ConsumerStatefulWidget {
  const HomePageMapView({super.key});

  @override
  ConsumerState<HomePageMapView> createState() => _HomePageMapViewState();
}

class _HomePageMapViewState extends ConsumerState<HomePageMapView> {
  MapController? controller;

  @override
  void initState() {
    super.initState();
    controller = ref.read(mapProvider);
// make sure to initialize before map loading
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(5, 5)),
            'assets/markers/man.png')
        .then((d) {
      controller!.customIcon = d;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    //controller = ref.read(mapProvider);
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Consumer(
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
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        controller!.getCurrentPosition();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: const Icon(Icons.location_pin),
                    ),
                  ),
                  AppSpace.spaceW10,
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Send Alert".toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          AppSpace.spaceW10,
                          const Icon(
                            Icons.send,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
