import 'package:aifer_task/core/constants/asset_constants.dart';
import 'package:aifer_task/core/theme/app_pallete.dart';
import 'package:aifer_task/core/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * .01),
      child: Center(child: Lottie.asset(AssetConstants.loaderIcon)),
    );
  }
}
