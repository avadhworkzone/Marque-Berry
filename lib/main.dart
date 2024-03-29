import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/appService/notification_service.dart';
import 'package:socialv/commanWidget/noInternet_screen.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/controllers/intrest_controller.dart';
import 'package:socialv/controllers/login_controller.dart';
import 'package:socialv/controllers/validate_otp_controller.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/view/drawer/campaign_screen.dart';
import 'package:socialv/view/drawer/template.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/view/message/chatting.dart';
import 'package:socialv/view/profile/edit_profile.dart';
import 'package:socialv/view/profile/following_screen.dart';
import 'package:socialv/view/sharePost/share_post.dart';
import 'package:socialv/view/sharePost/tag_a_people.dart';
import 'package:socialv/view/splash/splash_screen.dart';
import 'package:socialv/view/template/browser_template.dart';
import 'package:socialv/view/template/download_template_listview.dart';
import 'package:socialv/viewModel/auth_view_model.dart';
import 'package:socialv/viewModel/campaign_contest_view_model.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:socialv/viewModel/connectivity_view_model.dart';
import 'package:socialv/viewModel/create_post_view_model.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';
import 'package:socialv/viewModel/profile_view_model.dart';
import 'package:socialv/viewModel/template_view_model.dart';

import 'viewModel/drawer_viewmodel.dart';
import 'viewModel/setting_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Firebase.initializeApp(
      /*    options: FirebaseOptions(
          apiKey: "AIzaSyDDF9LnUPO7z60xSt_8tKG4UtbyFEKVr1U",
          appId: "1:988984878081:android:80c3e80083b66d9c7a4c00",
          messagingSenderId: "988984878081",
          projectId: "adoro-app")*/
      );

  /// FIREBASE BACKGROUND NOTIFICATION LISTENER
  FirebaseMessaging.onBackgroundMessage(
      NotificationService.firebaseMessagingBackgroundHandler);

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
              theme: PreferenceUtils.getString(key: PreferenceUtils.mode) ==
                  "dark"
                  ? AppTheme.darkTheme
                  : AppTheme.lightTheme,
              title: "ADORO",
              navigatorKey: Get.key,
              debugShowCheckedModeBanner: false,
              smartManagement: SmartManagement.full,
              onGenerateRoute: generateRoute,
              initialRoute: '/',
              // home: DemoStepCount(),
            );
          },
        );
      },
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => GetBuilder<ConnectivityViewModel>(
            init: ConnectivityViewModel(),
            builder: (connectivityViewModel) {
              if (connectivityViewModel.isOnline != null) {
                if (connectivityViewModel.isOnline!) {
                  // return HomeText();
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
    }
  }

  AuthViewModel authViewModel = Get.put(AuthViewModel());
  ProfileViewModel profileViewModel = Get.put(ProfileViewModel());
  TemplateViewModel templateViewModel = Get.put(TemplateViewModel());
  CreatePostViewModel createPostViewModel = Get.put(CreatePostViewModel());
  CategoryFeedViewModel categoryViewModel = Get.put(CategoryFeedViewModel());
  CampaignContestViewModel campaignContestViewModel =
      Get.put(CampaignContestViewModel());

  FollowFollowingViewModel followRequestViewModel =
      Get.put(FollowFollowingViewModel());

  ChattingController chattingController = Get.put(ChattingController());
  TemplateController templateController = Get.put(TemplateController());

  OtpController otpController = Get.put(OtpController());
  HomeController homeController = Get.put(HomeController());
  LoginController loginController = Get.put(LoginController());
  SettingViewModel settingController = Get.put(SettingViewModel());

  InterestController interestController = Get.put(InterestController());
  BottomBarController bottomController = Get.put(BottomBarController());
  SharePostController sharePostController = Get.put(SharePostController());
  TagAPeopleController tagAPeopleController = Get.put(TagAPeopleController());

  // MyTemplateController myTemplateController = Get.put(MyTemplateController());

  DownloadTemplateController downloadTemplateController =
      Get.put(DownloadTemplateController());

  BrowserTemplateController browserTemplateController =
      Get.put(BrowserTemplateController());

  FollowerFollowingController followerFollowingController =
      Get.put(FollowerFollowingController());

  CampaignScreenController campaignScreenController =
      Get.put(CampaignScreenController());

  EditProfileController editProfileController =
      Get.put(EditProfileController());
  DrawerVideModel drawerVideModel = Get.put(DrawerVideModel());
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    cardColor: ColorUtils.greyE5,
    scaffoldBackgroundColor: ColorUtils.white,
    canvasColor: Colors.grey[200],
    primaryTextTheme: const TextTheme(
      labelMedium: TextStyle(color: ColorUtils.black),
      caption: TextStyle(color: ColorUtils.grey),
    ),
    colorScheme: const ColorScheme.light(
        primary: ColorUtils.white,
        onPrimary: ColorUtils.white,
        secondary: ColorUtils.white,
        background: ColorUtils.lightGreyFA),
    iconTheme: const IconThemeData(color: ColorUtils.black),
    hintColor: ColorUtils.black,
    textTheme: TextTheme(
      titleSmall: TextStyle(color: ColorUtils.black),
      titleMedium: TextStyle(color: ColorUtils.black92),
      titleLarge: TextStyle(color: ColorUtils.black92),
      displaySmall: TextStyle(color: ColorUtils.blueB9),
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
    scaffoldBackgroundColor: ColorUtils.black2E,
    canvasColor: ColorUtils.black2E,

    primaryTextTheme: const TextTheme(
      labelMedium: TextStyle(color: ColorUtils.black),
      caption: TextStyle(color: ColorUtils.white),
    ),
    // appBarTheme: const AppBarTheme(
    //   brightness: Brightness.light,
    //   iconTheme: IconThemeData(color: ColorUtils.black),
    // ),
    colorScheme: const ColorScheme.light(
      primary: ColorUtils.white,
      onPrimary: ColorUtils.white,
      secondary: ColorUtils.white,
      background: ColorUtils.darkBlue3A,
    ),
    iconTheme: const IconThemeData(color: ColorUtils.black),
    hintColor: ColorUtils.black,
    textTheme: const TextTheme(
      titleSmall: TextStyle(color: ColorUtils.white),
      titleMedium: TextStyle(color: ColorUtils.white),
      titleLarge: TextStyle(color: ColorUtils.blueB9),
      displaySmall: TextStyle(color: ColorUtils.white),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: ColorUtils.white),
      filled: true,
      fillColor: ColorUtils.white,
    ),
  );
}

// https://api.postman.com/collections/2554210-f52106ae-9e3d-47a0-b2e3-d7eb1c319143?access_key=PMAT-01GPJBWJMNT4JBECTXF38YV17R
