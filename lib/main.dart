import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebox/views/screens/splash%20screen/splash.dart';
import 'bindings/general_bindings.dart';
import 'data/authentication repository/authentication_repository.dart';
import 'firebase_options.dart';
import 'utils/constants/app_colors.dart';
import 'package:get/get.dart';

Future<void> main() async {
  // Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Await Splash Screen until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const NoteBoxApp());
}

class NoteBoxApp extends StatelessWidget {
  const NoteBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return GetMaterialApp(
        title: 'NoteBox',
        debugShowCheckedModeBanner: false,
        initialBinding: GeneralBindings(),
        theme: ThemeData(
          useMaterial3: true,
        ).copyWith(scaffoldBackgroundColor: AppColors.backgroundColor),
        home: const SplashScreen());
  }
}
