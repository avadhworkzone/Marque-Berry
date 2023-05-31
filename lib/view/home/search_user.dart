import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/get_search_users_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/profile/profile.dart';
import 'package:socialv/viewModel/profile_view_model.dart';

class SearchUser extends StatelessWidget {
  SearchUser({Key? key}) : super(key: key);

  final ProfileViewModel profileViewModel = Get.find<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.w),
        child: CommonAppBar(
          title: 'Search',
          onTap: () => Get.back(),
        ),
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
              Padding(
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
                      // suffixIcon: Icon(Icons.search,color: whiteBlack2E,),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: black92White!),
                          borderRadius: BorderRadius.circular(10.sp)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: black92White),
                          borderRadius: BorderRadius.circular(10.sp)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: black92White),
                          borderRadius: BorderRadius.circular(10.sp)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: black92White),
                          borderRadius: BorderRadius.circular(10.sp))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: searchUsersResModel.data?.length??0,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      Divider(indent: 10, endIndent: 20, color: black92White),
                  itemBuilder: (context, index) {
                    final userData = searchUsersResModel.data![index];
                    return ListTile(
                      onTap: () {
                        Get.to(() => Profile(userId: userData.id!));
                      },
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
                            image: NetworkImage(''),
                            // image: NetworkImage(userData.image ?? ""),
                            progressIndicatorBuilder: (context, progress) {
                              double? value;
                              var expectedBytes = progress?.expectedTotalBytes;
                              if (progress != null && expectedBytes != null) {
                                value = progress.cumulativeBytesLoaded /
                                    expectedBytes;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: value,
                                  color: blackWhite,
                                ),
                              );
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
                        color: blackWhite,
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
