import 'dart:async';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/view/auth/interest.dart';
import 'package:socialv/view/home/home.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/routes/route_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socialv/view/drawer/setting.dart';
import 'package:socialv/routes/route_constant.dart';
import 'package:socialv/view/sharePost/share_post.dart';
import 'package:socialv/viewModel/auth_view_model.dart';
import 'package:socialv/controllers/login_controller.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:socialv/controllers/intrest_controller.dart';
import 'package:socialv/commanWidget/noInternet_screen.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/viewModel/connectivity_view_model.dart';
import 'package:socialv/controllers/validate_otp_controller.dart';
import 'package:socialv/viewModel/create_post_view_model.dart';

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
              theme:
                  PreferenceUtils.getString(key: PreferenceUtils.mode) == "dark"
                      ? AppTheme.darkTheme
                      : AppTheme.lightTheme,
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
                      return InterestScreen();
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

  AuthViewModel authViewModel = Get.put(AuthViewModel());
  CreatePostViewModel createPostViewModel = Get.put(CreatePostViewModel());
  CategoryFeedViewModel categoryViewModel = Get.put(CategoryFeedViewModel());

  OtpController otpController = Get.put(OtpController());
  HomeController homeController = Get.put(HomeController());
  LoginController loginController = Get.put(LoginController());
  SettingController settingController = Get.put(SettingController());
  InterestController interestController = Get.put(InterestController());
  BottomBarController bottomController = Get.put(BottomBarController());
  SharePostController sharePostController = Get.put(SharePostController());
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    cardColor: ColorUtils.white,
    scaffoldBackgroundColor: ColorUtils.white,

    canvasColor: Colors.grey[200],
    primaryTextTheme: const TextTheme(
      labelMedium: TextStyle(color: ColorUtils.black),
    ),
    // appBarTheme: const AppBarTheme(
    //   brightness: Brightness.light,
    //   iconTheme: IconThemeData(color: ColorUtils.black),
    // ),
    buttonColor: ColorUtils.black,
    colorScheme: const ColorScheme.light(
      primary: ColorUtils.white,
      onPrimary: ColorUtils.white,
      secondary: ColorUtils.white,
    ),
    iconTheme: const IconThemeData(color: ColorUtils.black),
    hintColor: ColorUtils.black,
    textTheme: TextTheme(
      titleSmall: TextStyle(color: ColorUtils.black),
      titleMedium: TextStyle(color: ColorUtils.black92),
      titleLarge: TextStyle(color: ColorUtils.black92),
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
    cardColor: ColorUtils.black2E,
    canvasColor: ColorUtils.black2E,
    buttonColor: ColorUtils.white,
    scaffoldBackgroundColor: ColorUtils.black2E,
    primaryTextTheme: const TextTheme(
      labelMedium: TextStyle(color: ColorUtils.black),
    ),
    // appBarTheme: const AppBarTheme(
    //   brightness: Brightness.light,
    //   iconTheme: IconThemeData(color: ColorUtils.black),
    // ),
    colorScheme: const ColorScheme.light(
      primary: ColorUtils.white,
      onPrimary: ColorUtils.white,
      secondary: ColorUtils.white,
    ),
    iconTheme: const IconThemeData(color: ColorUtils.black),
    hintColor: ColorUtils.black,
    textTheme: const TextTheme(
      titleSmall: TextStyle(color: ColorUtils.white),
      titleMedium: TextStyle(color: ColorUtils.white),
      titleLarge: TextStyle(color: ColorUtils.blueB9),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: ColorUtils.white),
      filled: true,
      fillColor: ColorUtils.white,
    ),
  );
}
