import 'package:flutter/material.dart';

import '../../../Constants/app_strings.dart';
import '../../../Widgets/kAppBar.dart';

class AppBarPanel extends StatelessWidget {
  const AppBarPanel({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.paddingOf(context).top + 10,
      left: 0,
      right: 0,
      child: kAppBar(
        size: size,
        title: AppStrings.appName,
      ),
    );
  }
}
