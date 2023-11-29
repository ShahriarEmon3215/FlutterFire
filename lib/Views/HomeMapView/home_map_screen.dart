import 'package:flutter/material.dart';
import 'package:flutter_fire/Controller/map_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'views/app_bar_panel.dart';
import 'views/bottom_menu.dart';
import 'views/map_custom_view.dart';

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
            MapCustomView(size: size), // map view
            AppBarPanel(size: size), // Positioned to top
            BottomOptions(controller: controller),  // Positioned to bottom
          ],
        ),
      ),
    );
  }
}


