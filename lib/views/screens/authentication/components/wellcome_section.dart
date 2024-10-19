import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notebox/utils/constants/app_images.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';

class GoogleAuthentWellcomeSection extends StatefulWidget {
  const GoogleAuthentWellcomeSection({super.key});

  @override
  State<GoogleAuthentWellcomeSection> createState() =>
      _GoogleAuthentWellcomeSectionState();
}

class _GoogleAuthentWellcomeSectionState
    extends State<GoogleAuthentWellcomeSection> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      child: Stack(
        children: [
          Transform.scale(
              scale: 1,
              child: Transform.translate(
                  offset: const Offset(0, 0),
                  child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 1000),
                      opacity: animate ? 1 : 0,
                      child: Image.asset(AppAssets.authComponent1)))),
          Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: animate ? 1 : 0,
                child: Image.asset(
                  AppAssets.authComponent3,
                  height: ResponsiveSize.h * 60,
                ),
              )),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              bottom: MediaQuery.of(context).size.height * 0.12,
              right: animate ? -10 : -30,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: animate ? 1 : 0,
                child: Transform.rotate(
                  angle: 5,
                  child: Image.asset(
                    AppAssets.authComponent2,
                    height: ResponsiveSize.h * 50,
                  ),
                ),
              )),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: animate ? 1 : 0,
                child: Image.asset(
                  AppAssets.authComponent4,
                  height: ResponsiveSize.h * 50,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: animate ? 1 : 0,
              child: LottieBuilder.asset(
                AppAssets.authComponent5,
                repeat: true,
                animate: true,
                height: ResponsiveSize.h * 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
