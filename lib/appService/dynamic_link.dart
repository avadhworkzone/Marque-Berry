import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/view/auth/login_screen.dart';
import 'package:socialv/view/bottomBar/bottombar.dart';
import 'package:socialv/view/home/post_detail_screen.dart';

class DynamicLink {
  /// MAIN CONTENT
  static String uriPrefix = "https://socialv.page.link";
  // static String domainLink = "https://www.adoro.social";
  static final dynamicLinks = FirebaseDynamicLinks.instance;

  /// CUSTOMER APP CONTENT
  static String androidBundleIdUser = "com.creator.adoro";
  static String iosBundleIdUser = "";
  static String appStoreIdUser = "";

  /// CREATE DEEP LINK URL FOR POST
  static Future<String> createDynamicLinkForPost(
      {bool short = true, required String postId}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: uriPrefix,

      ///ADD YOUR FIREBASE LINK URL....
      link: Uri.parse("$uriPrefix/post?postId=$postId"),

      ///ADD YOUR DOMAIN URL...
      androidParameters: AndroidParameters(
        packageName: androidBundleIdUser,
        minimumVersion: 0,
      ),

      iosParameters: IOSParameters(
          bundleId: iosBundleIdUser,
          minimumVersion: '1',
          appStoreId: appStoreIdUser),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    print("SHORT LINK ${url.toString()}");
    return url.toString();
  }

  /// CREATE DEEP LINK URL FOR POST
  static Future<String> createDynamicLinkForReferAndErn(
      {bool short = true, required String referId}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: uriPrefix,

      ///ADD YOUR FIREBASE LINK URL....
      link: Uri.parse("$uriPrefix/refer?referId=$referId"),

      ///ADD YOUR DOMAIN URL...
      androidParameters: AndroidParameters(
        packageName: androidBundleIdUser,
        minimumVersion: 0,
      ),

      iosParameters: IOSParameters(
          bundleId: iosBundleIdUser,
          minimumVersion: '1',
          appStoreId: appStoreIdUser),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    print("SHORT LINK ${url.toString()}");
    return url.toString();
  }

  /// CALL WHEN APP IS KILLED
  static void getInitialDynamicLinks() async {
    final PendingDynamicLinkData? data = await dynamicLinks.getInitialLink();
    final Uri? deepLink = data?.link;

    print('DEEP LINK :$deepLink');
    if (deepLink != null) {
      if (PreferenceUtils.getInt(key: PreferenceUtils.login) == 0) {
        String? referId;
        if (deepLink.toString().contains('referId')) {
          referId = deepLink
              .toString()
              .substring(deepLink.toString().indexOf('=') + 1);
        }
        Get.off(() => LoginScreen(
              referId: referId,
            ));
      } else {
        final postId =
            deepLink.toString().substring(deepLink.toString().indexOf('=') + 1);
        logs('GET INIT POSt ID =>$postId');
        Get.to(() => PostDetailScreen(
              postId: postId,
            ));
      }
    } else {
      navigatePage();
    }
  }

  static void navigatePage() {
    Future.delayed(
      const Duration(seconds: 2, milliseconds: 500),
      () => Get.offAll(
        () => PreferenceUtils.getInt(key: PreferenceUtils.login) == 0
            ? LoginScreen()
            : BottomBar(),
      ),
    );
  }

  /// CALL WHEN APP IS OPEN
  static void listenDynamicLinks() {
    dynamicLinks.onLink.listen((event) async {
      print('CAL>>>>>>>>>>>${event.link} ');
      final Uri deepLink = event.link;
      print('DEEP LINK :$deepLink');

      if (deepLink != null) {
        if (PreferenceUtils.getInt(key: PreferenceUtils.login) == 0) {
          String? referId;
          if (deepLink.toString().contains('referId')) {
            referId = deepLink
                .toString()
                .substring(deepLink.toString().indexOf('=') + 1);
          }
          Get.off(() => LoginScreen(
                referId: referId,
              ));
        } else {
          final postId = deepLink
              .toString()
              .substring(deepLink.toString().indexOf('=') + 1);
          print('POST ID ==>$postId');
          Get.to(() => PostDetailScreen(postId: postId));
        }
      } else {
        print('CONTINUE WITHOUT DEEP LINK.............');
      }
    }).onError((error) {
      print('DYNAMIC LINK LISTING ERROR :=>${error.message}');
    });
  }
}
