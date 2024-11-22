import 'package:aifer_task/core/constants/asset_constants.dart';
import 'package:aifer_task/core/utils.dart';

import 'package:aifer_task/features/nav/view/pages/nav_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          navigate(
              context: context,
              screen: const NavScreen(),
              type: NavigationType.pushAndRemoveUntil);
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetConstants.splashImg), fit: BoxFit.cover)),
    ));
  }
}
