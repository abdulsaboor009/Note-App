import 'package:flutter/material.dart';
import 'package:notebox/utils/constants/app_images.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/responsive_sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   navigateToNextScreen();
  // }

  // void navigateToNextScreen() async {
  //   await Future.delayed(const Duration(seconds: 3), () {
  //     Get.to(() => const GoogleAuthenticationScreen());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: LottieBuilder.asset(AppAssets.logo2,
                repeat: false, animate: true, height: ResponsiveSize.h * 220),
          ),
        ],
      ),
    );
  }
}
