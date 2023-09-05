import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../Models/location_model.dart';

class MapController extends ChangeNotifier {
  Completer<GoogleMapController> gMapController =
      Completer<GoogleMapController>();
  Location location = new Location();
  Set<Marker> markers = Set<Marker>();
  List<Alllocations> locations = [
    Alllocations(
      title: "slkdjlf",
      latitude: "23.75335188819229",
      longtude: "90.41668351739645",
    ),
    Alllocations(
      title: "eeee",
      latitude: "23.7528668",
      longtude: "90.4177",
    ),
  ];

  LocationDataModel? data;

  BitmapDescriptor? customIcon;
  bool loadMap = false;
  bool mapFirstClicked = false;

  CameraPosition myCurrentLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void getCurrentLocation() async {
    final GoogleMapController googleMapController = await gMapController.future;
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(_locationData.latitude!, _locationData.longitude!),
        zoom: 17.0,
      ),
    ));
    notifyListeners();
  }

  Set<Marker> getMarkers() {
    for (int i = 0; i < locations.length; i++) {
      markers.add(Marker(
        markerId: MarkerId(locations[i].id.toString()),
        position: LatLng(double.parse(locations[i].latitude!),
            double.parse(locations[i].longtude!)),
        infoWindow: InfoWindow(
          title: locations[i].title,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    }

    return markers;
  }

  handleTap(LatLng point, BuildContext context) {
    if (mapFirstClicked == false) {
      mapFirstClicked = true;

      markers.add(
        marker(point, context),
      );
    } else if (mapFirstClicked == true) {
      markers.removeWhere((element) => element == markers.last);
      markers.add(
        marker(point, context),
      );
    }
    notifyListeners();
  }

  Marker marker(LatLng point, BuildContext context) {
    return Marker(
      markerId: MarkerId(point.toString()),
      position: point,
      infoWindow: InfoWindow(
        title: 'Ask for help!',
        onTap: () {
          showModalBottomSheet<void>(
              context: context,
              builder: ((context) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        "Ask for help!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Type here...",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 150,
                        child: ElevatedButton(
                            onPressed: (() {}),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("SEND ALERT"),
                                SizedBox(width: 10),
                                Icon(Icons.send)
                              ],
                            )),
                      )
                    ],
                  ),
                );
              }));
        },
      ),
      icon: customIcon!,
    );
  }
}
