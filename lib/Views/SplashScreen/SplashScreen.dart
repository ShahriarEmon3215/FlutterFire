import 'package:flutter/material.dart';
import 'package:flutter_fire/Utils/context.dart';
import 'package:flutter_fire/Views/HomeMapView/HomePageMapView.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      context.pushAndRemoveUntil(const HomePageMapView());
    });
  }

  Future init() async {
    await Permission.location.request();
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("FlutterFire"),
      ),
    );
  }
}
