import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socialv/routes/route_constant.dart';
import 'package:socialv/routes/route_helper.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/view/splash/splash_screen.dart';
import 'package:socialv/viewModel/connectivity_view_model.dart';

import 'commanWidget/noInternet_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

StreamController<bool> isLightTheme = StreamController();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityViewModel connectivityViewModel =
      Get.put(ConnectivityViewModel());

  @override
  initState() {
    super.initState();
    connectivityViewModel.startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return StreamBuilder<Object>(
          initialData: true,
          stream: isLightTheme.stream,
          builder: (context, AsyncSnapshot snapshot) {
            return GetMaterialApp(
              theme: AppTheme.lightTheme,
              // PreferenceUtils.getLightMode() == "light"
              //     ? AppTheme.darkTheme
              //     : AppTheme.lightTheme,
              title: "ADORO",
              navigatorKey: Get.key,
              getPages: RouteHelper.routes,
              debugShowCheckedModeBanner: false,
              initialRoute: RouteConstant.inital,
              smartManagement: SmartManagement.full,
              home: GetBuilder<ConnectivityViewModel>(
                init: ConnectivityViewModel(),
                builder: (connectivityViewModel) {
                  if (connectivityViewModel.isOnline != null) {
                    if (connectivityViewModel.isOnline!) {
                      return SplashScreen();
                    } else {
                      return const NoInterNetConnected();
                    }
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  BottomBarController bottomController = Get.put(BottomBarController());
  HomeController homeController = Get.put(HomeController());
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    // useMaterial3: true,
    fontFamily: 'Poppins',
    cardColor: ColorUtils.white,
    scaffoldBackgroundColor: ColorUtils.white,

    primaryTextTheme: const TextTheme(
      labelMedium: TextStyle(color: ColorUtils.black),
      // subtitle1: TextStyle(color: ColorUtils.black85),
    ),
    appBarTheme: const AppBarTheme(
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: ColorUtils.black),
    ),
    colorScheme: const ColorScheme.light(
      primary: ColorUtils.white,
      onPrimary: ColorUtils.white,
      secondary: ColorUtils.white,
    ),
    iconTheme: const IconThemeData(color: ColorUtils.black),
    hintColor: ColorUtils.black,
    textTheme: const TextTheme(
      subtitle1: TextStyle(color: ColorUtils.black),
      bodyText1: TextStyle(color: ColorUtils.greyFA),
      bodyText2: TextStyle(color: ColorUtils.white),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: ColorUtils.white),
      filled: true,
      fillColor: ColorUtils.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    // useMaterial3: true,
    fontFamily: 'Poppins',
    cardColor: ColorUtils.white,
    scaffoldBackgroundColor: ColorUtils.white,
    primaryTextTheme: const TextTheme(
      labelMedium: TextStyle(color: ColorUtils.black),
      // subtitle1: TextStyle(color: ColorUtils.black85),
    ),
    appBarTheme: const AppBarTheme(
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: ColorUtils.black),
    ),
    colorScheme: const ColorScheme.light(
      primary: ColorUtils.white,
      onPrimary: ColorUtils.white,
      secondary: ColorUtils.white,
    ),
    iconTheme: const IconThemeData(color: ColorUtils.black),
    hintColor: ColorUtils.black,
    textTheme: const TextTheme(
      subtitle1: TextStyle(color: ColorUtils.black),
      bodyText1: TextStyle(color: ColorUtils.greyFA),
      bodyText2: TextStyle(color: ColorUtils.white),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: ColorUtils.white),
      filled: true,
      fillColor: ColorUtils.white,
    ),
  );
}
