import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/commanWidget/search_textfield.dart';
import 'package:socialv/model/apiModel/responseModel/get_search_users_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/viewModel/profile_view_model.dart';

class TagAPeople extends StatelessWidget {
  TagAPeople({Key? key}) : super(key: key);

  final ProfileViewModel profileViewModel = Get.find<ProfileViewModel>();
  RxList<RxString> selectedTagList = <RxString>[].obs;
  TagAPeopleController tagAPeopleController = Get.find<TagAPeopleController>();

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: customAppbar(
        title: 'Tag friend',
        context: context,
        icon: Obx(() => selectedTagList.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  tagAPeopleController.tagList =
                      selectedTagList.value.map((e) => e.value).toList();
                  Get.back();
                },
                child: Container(
                  width: 20.w,
                  height: 5.h,
                  // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Center(child: Text('Done')),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(ImagesWidgets.gradientRectangle),
                  )),
                ),
              )
            /*IconButton(
                splashRadius: 6.w,
                onPressed: () {
                  // tagAPeopleController.clearList();
                },
                icon: Icon(Icons.close, color: blackWhite),
              )*/
            : SizedBox()),
      ),
      body: GetBuilder<ProfileViewModel>(
        initState: (state) {
          profileViewModel.searchUsers("");
        },
        builder: (cont) {
          if (cont.searchUserProfileApiResponse.status == Status.LOADING ||
              cont.searchUserProfileApiResponse.status == Status.INITIAL) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (cont.searchUserProfileApiResponse.status == Status.ERROR) {
            return Center(child: SomethingWentWrong());
          }
          GetSearchUsersResModel searchUsersResModel =
              cont.searchUserProfileApiResponse.data;
          // if (searchUsersResModel.status != 200 ||
          //     (searchUsersResModel.data?.isEmpty ?? true) == true) {
          //   return Center(
          //     child: AdoroText(
          //       VariableUtils.noDataFound,
          //     ),
          //   );
          // }

          return Column(
            children: [
              /*  Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  cursorColor: ColorUtils.black,
                  onChanged: (value) {
                    profileViewModel.searchUsers(value);
                  },
                  decoration: InputDecoration(
                      fillColor: ColorUtils.white,
                      filled: true,
                      hintText: 'Search..',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xff6F7F92),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: black92White!),
                          borderRadius: BorderRadius.circular(5.sp)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: black92White),
                          borderRadius: BorderRadius.circular(5.sp)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: black92White),
                          borderRadius: BorderRadius.circular(5.sp)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: black92White),
                          borderRadius: BorderRadius.circular(5.sp))),
                ),
              ),*/
              SearchTextField(
                  verticalPadding: 0,
                  onChangedString: (value) {
                    profileViewModel.searchUsers(value);
                  }),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: searchUsersResModel.data?.length ?? 0,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      Divider(indent: 10, endIndent: 20, color: black92White),
                  itemBuilder: (context, index) {
                    final userData = searchUsersResModel.data![index];
                    if (userData.id ==
                        PreferenceUtils.getInt(key: PreferenceUtils.userid)) {
                      return SizedBox();
                    }
                    return InkWell(
                      splashColor: ColorUtils.transparent,
                      highlightColor: ColorUtils.transparent,
                      onTap: () {
                        if (selectedTagList.contains(userData.id.toString())) {
                          selectedTagList.remove(userData.id.toString().obs);
                        } else {
                          selectedTagList.add(userData.id.toString().obs);
                        }
                      },
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10.w),
                          child: Container(
                            height: 10.w,
                            width: 10.w,
                            color: ColorUtils.greyFA,
                            child: OctoImage(
                              fit: BoxFit.cover,
                              width: 24,
                              height: 24,
                              image: NetworkImage(
                                userData.image ?? "",
                              ),
                              progressIndicatorBuilder: (context, progress) {
                                double? value;
                                var expectedBytes =
                                    progress?.expectedTotalBytes;
                                if (progress != null && expectedBytes != null) {
                                  value = progress.cumulativeBytesLoaded /
                                      expectedBytes;
                                }
                                return Center(child: Loader());
                              },
                              errorBuilder: (context, error, stacktrace) =>
                                  Container(
                                width: 24,
                                height: 24,
                                color: ColorUtils.grey[200],
                                child: Padding(
                                  padding: EdgeInsets.all(1.w),
                                  child: CommonImage(
                                    img: IconsWidgets.userImages,
                                    color: ColorUtils.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AdoroText(
                              userData.username ?? VariableUtils.naError,
                              fontSize: 13.sp,
                              color: blackWhite,
                              fontWeight: FontWeightClass.fontWeight600,
                            ),
                            SizeConfig.sH05,
                          ],
                        ),
                        subtitle: AdoroText(
                          userData.fullName ?? "",
                          fontSize: 10.sp,
                          color: ColorUtils.black92,
                        ),
                        trailing: Obx(() =>
                            selectedTagList.contains(userData.id.toString())
                                ? Icon(Icons.check, color: blackWhite)
                                : SizedBox()),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// // ignore_for_file: must_be_immutable, unused_local_variable
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:octo_image/octo_image.dart';
// import 'package:sizer/sizer.dart';
// import 'package:socialv/commanWidget/common_appbar.dart';
// import 'package:socialv/commanWidget/loader.dart';
// import 'package:socialv/model/apiModel/responseModel/get_follower_list_res_model.dart';
// import 'package:socialv/model/apis/api_response.dart';
// import 'package:socialv/utils/const_utils.dart';
// import 'package:socialv/utils/decoration_utils.dart';
// import 'package:socialv/utils/shared_preference_utils.dart';
// import 'package:socialv/utils/validation_utils.dart';
// import 'package:socialv/viewModel/follow_request_view_model.dart';
//
// import '../../commanWidget/common_image.dart';
// import '../../utils/assets/images_utils.dart';
// import '../../utils/color_utils.dart';
// import '../../utils/custom_text_field.dart';
// import '../../utils/font_style_utils.dart';
// import '../../utils/size_config_utils.dart';
// import '../../utils/adoro_text.dart';
// import '../../utils/variable_utils.dart';
//
// class TagAPeople extends StatelessWidget {
//   TagAPeople({Key? key}) : super(key: key);
//
//   FollowFollowingViewModel followRequestViewModel =
//       Get.find<FollowFollowingViewModel>();
//   var search = TextEditingController();
//   TagAPeopleController _tagAPeopleController = Get.find<TagAPeopleController>();
//   RxList<RxString> selectedTagList = <RxString>[].obs;
//
//   @override
//   Widget build(BuildContext context) {
//     Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
//
//     return Scaffold(
//       appBar: customAppbar(
//         title: 'Tag friend',
//         context: context,
//         icon: Obx(() => selectedTagList.isNotEmpty
//             ? GestureDetector(
//                 onTap: () {
//                   _tagAPeopleController.tagList = selectedTagList.value.map((e) => e.value).toList();
//                   Get.back();
//                 },
//                 child: Container(
//                   width: 20.w,
//                   height: 5.h,
//                   // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//                   child: Center(child: Text('Done')),
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                     image: AssetImage(ImagesWidgets.gradientRectangle),
//                   )),
//                 ),
//               )
//             /*IconButton(
//                 splashRadius: 6.w,
//                 onPressed: () {
//                   // tagAPeopleController.clearList();
//                 },
//                 icon: Icon(Icons.close, color: blackWhite),
//               )*/
//             : SizedBox()),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.w),
//         child: Column(
//           children: [
//             SizeConfig.sH1,
//             Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26.withOpacity(0.2),
//                     blurRadius: 1.0,
//                     spreadRadius: 0.2,
//                     offset: const Offset(0.0, 0.0),
//                   ),
//                 ],
//               ),
//               child: SearchTextFormField(
//                 color: blackWhite,
//                 validator: () {},
//                 controller: search,
//                 denyInput: false,
//                 hintText: 'Search...',
//                 hintStyle: TextStyle(color: blackWhite),
//                 denyInputFormatters: '[]',
//                 allowInputFormatters: RegularExpression.alphabetDigitsSpacePattern,
//               ),
//             ),
//             SizeConfig.sH2,
//             GetBuilder<FollowFollowingViewModel>(
//               initState: (_) async {
//                 await followRequestViewModel.getFollowerList( (PreferenceUtils.getInt(key: 'userid')).toString());
//               },
//               builder: (followRequestViewModel) {
//                 if (followRequestViewModel.getFollowerListApiResponse.status ==
//                         Status.LOADING ||
//                     followRequestViewModel.getFollowerListApiResponse.status ==
//                         Status.INITIAL) {
//                   return Center(child: Loader());
//                 } else if (followRequestViewModel
//                         .getFollowerListApiResponse.status ==
//                     Status.ERROR) {
//                   return Center(child: SomethingWentWrong());
//                 }
//                 final GetFollowerListResModel getFollowerListResModel =
//                     followRequestViewModel.getFollowerListApiResponse.data;
//                 if (getFollowerListResModel.status.toString() ==
//                     VariableUtils.status500) {
//                   return Center(
//                     child: AdoroText(
//                       getFollowerListResModel.msg ??
//                           VariableUtils.somethingWentWrong,
//                     ),
//                   );
//                 }
//                 return Expanded(
//                   child: SingleChildScrollView(
//                     child: ListView.builder(
//                       itemCount: getFollowerListResModel.data?.length ?? 0,
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         final followData = getFollowerListResModel.data?[index];
//
//                         String tagId = ((followData?.id.toString()) ?? "");
//                         return Column(
//                           children: [
//                             InkWell(
//                               splashColor: ColorUtils.transparent,
//                               highlightColor: ColorUtils.transparent,
//                               onTap: () {
//                                 // tagAPeopleController.addList(tagId);
//                                 if (selectedTagList.contains(tagId)) {
//                                   selectedTagList.remove(tagId.obs);
//                                 } else {
//                                   selectedTagList.add(tagId.obs);
//                                 }
//                               },
//                               child: ListTile(
//                                 leading: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10.w),
//                                   child: Container(
//                                     height: 10.w,
//                                     width: 10.w,
//                                     color: ColorUtils.greyFA,
//                                     child: OctoImage(
//                                       fit: BoxFit.cover,
//                                       width: 24,
//                                       height: 24,
//                                       image: NetworkImage(
//                                         followData?.image ?? "",
//                                       ),
//                                       progressIndicatorBuilder:
//                                           (context, progress) {
//                                         double? value;
//                                         var expectedBytes =
//                                             progress?.expectedTotalBytes;
//                                         if (progress != null &&
//                                             expectedBytes != null) {
//                                           value =
//                                               progress.cumulativeBytesLoaded /
//                                                   expectedBytes;
//                                         }
//                                         return Center(child: Loader());
//                                       },
//                                       errorBuilder:
//                                           (context, error, stacktrace) =>
//                                               Container(
//                                         width: 24,
//                                         height: 24,
//                                         color: ColorUtils.grey[200],
//                                         child: Padding(
//                                           padding: EdgeInsets.all(1.w),
//                                           child: CommonImage(
//                                             img: IconsWidgets.userImages,
//                                             color: ColorUtils.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 title: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     AdoroText(
//                                       followData?.username ??
//                                           VariableUtils.naError,
//                                       fontSize: 13.sp,
//                                       color: blackWhite,
//                                       fontWeight: FontWeightClass.fontWeight600,
//                                     ),
//                                     SizeConfig.sH05,
//                                   ],
//                                 ),
//                                 subtitle: AdoroText(
//                                   followData?.fullName ?? "",
//                                   fontSize: 10.sp,
//                                   color: ColorUtils.black92,
//                                 ),
//                                 trailing: Obx(() =>
//                                     selectedTagList.contains(tagId)
//                                         ? Icon(Icons.check, color: blackWhite)
//                                         : SizedBox()),
//                               ),
//                             ),
//                             DecorationUtils.dividerLine1(),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
class TagAPeopleController extends GetxController {
  List<String> tagList = [];

  void clearList() {
    tagList.clear();
    update();
  }
}
