import 'package:flutter/material.dart';
import 'package:flutter_fire/Controller/map_controller.dart';
import 'package:flutter_fire/Views/HomeMapView/HomePageMapView.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider<MapController>(create: (_) => MapController()),
      ],
      child: MaterialApp(
        title: 'FlutterFire',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePageMapView(),
      ),
    );
  }
}
