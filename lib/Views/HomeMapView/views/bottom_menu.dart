import 'package:flutter/material.dart';

import '../../../Controller/map_controller.dart';
import '../../../Utils/app_space.dart';

class BottomOptions extends StatelessWidget {
  const BottomOptions({
    super.key,
    required this.controller,
  });

  final MapController? controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}
