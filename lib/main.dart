import 'dart:async';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/view/auth/interest.dart';
import 'package:socialv/view/drawer/campaign_screen.dart';
import 'package:socialv/view/home/home.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/routes/route_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socialv/view/drawer/setting.dart';
import 'package:socialv/routes/route_constant.dart';
import 'package:socialv/view/message/chatting.dart';
import 'package:socialv/view/profile/edit_profile.dart';
import 'package:socialv/view/profile/following_screen.dart';
import 'package:socialv/view/profile/profile1_screen.dart';
import 'package:socialv/view/sharePost/share_post.dart';
import 'package:socialv/view/sharePost/tag_a_people.dart';
import 'package:socialv/view/splash/splash_screen.dart';
import 'package:socialv/view/template/my_template.dart';
import 'package:socialv/viewModel/auth_view_model.dart';
import 'package:socialv/controllers/login_controller.dart';
import 'package:socialv/viewModel/campaign_contest_view_model.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:socialv/controllers/intrest_controller.dart';
import 'package:socialv/commanWidget/noInternet_screen.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/viewModel/connectivity_view_model.dart';
import 'package:socialv/controllers/validate_otp_controller.dart';
import 'package:socialv/viewModel/create_post_view_model.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';
import 'package:socialv/viewModel/profile_view_model.dart';
import 'package:socialv/viewModel/template_view_model.dart';

import 'view/drawer/template.dart';
import 'view/template/browser_template.dart';

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
              theme: //AppTheme.darkTheme,
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
                      return SplashScreen();
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

  AuthViewModel authViewModel = Get.put(AuthViewModel());
  ProfileViewModel profileViewModel = Get.put(ProfileViewModel());
  TemplateViewModel templateViewModel = Get.put(TemplateViewModel());
  CreatePostViewModel createPostViewModel = Get.put(CreatePostViewModel());
  CategoryFeedViewModel categoryViewModel = Get.put(CategoryFeedViewModel());

  CampaignContestViewModel campaignContestViewModel =
      Get.put(CampaignContestViewModel());

  FollowRequestViewModel followRequestViewModel =
      Get.put(FollowRequestViewModel());

  ChattingController chattingController = Get.put(ChattingController());
  TemplateController templateController = Get.put(TemplateController());

  ProfileController profileController = Get.put(ProfileController());
  OtpController otpController = Get.put(OtpController());
  HomeController homeController = Get.put(HomeController());
  LoginController loginController = Get.put(LoginController());
  SettingController settingController = Get.put(SettingController());

  InterestController interestController = Get.put(InterestController());
  BottomBarController bottomController = Get.put(BottomBarController());
  SharePostController sharePostController = Get.put(SharePostController());

  MyTemplateController myTemplateController = Get.put(MyTemplateController());

  BrowserTemplateController browserTemplateController =
      Get.put(BrowserTemplateController());

  FollowerFollowingController followerFollowingController =
      Get.put(FollowerFollowingController());

  CampaignScreenController campaignScreenController =
      Get.put(CampaignScreenController());

  EditProfileController editProfileController =
      Get.put(EditProfileController());

  TagAPeopleController tagAPeopleController = Get.put(TagAPeopleController());
}

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTMsImlhdCI6MTY4MTIwODM3NiwiZXhwIjoxNjgyMDcyMzc2fQ.0ui6YLqzLpSj9hb84ErHGNn55ST0osUYEO-uBH-RdoU
// https://api.postman.com/collections/2554210-f52106ae-9e3d-47a0-b2e3-d7eb1c319143?access_key=PMAT-01GPJBWJMNT4JBECTXF38YV17R

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',

    cardColor: ColorUtils.grey.withOpacity(0.12),
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
    buttonColor: ColorUtils.white,
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
      displaySmall: TextStyle(color: ColorUtils.white),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: ColorUtils.white),
      filled: true,
      fillColor: ColorUtils.white,
    ),
  );
}
