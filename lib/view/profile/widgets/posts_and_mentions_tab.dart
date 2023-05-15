import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/model/apiModel/responseModel/user_profile_res_model.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/view/profile/mentions_post.dart';
import 'package:socialv/view/profile/show_post.dart';
import 'package:socialv/viewModel/profile_view_model.dart';

class PostsAndMentionsTab extends StatelessWidget {
  const PostsAndMentionsTab({
    super.key,
    required this.con,
    required this.profileResModel,
  });

  final ProfileViewModel con;
  final UserProfileResModel profileResModel;

  @override
  Widget build(BuildContext context) {
    final profile = profileResModel.data!.first;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 3.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.w),
          color: whiteBlack2E,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.5.w,
            vertical: 3.5.w,
          ),
          child: Column(
            children: [
              Container(
                height: 12.w,
                width: 90.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => con.changeTab(0),
                      child: Container(
                        child: Column(
                          children: [
                            Spacer(),
                            Container(
                              width: 40.w,
                              child: Center(
                                child: AdoroText(
                                  "All posts",
                                  color: con.tabIndex == 0
                                      ? ColorUtils.blueB9
                                      : black92White,
                                  fontWeight: FontWeightClass.fontWeight700,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 0.5.w,
                              width: 40.w,
                              color: con.tabIndex == 0
                                  ? ColorUtils.blueB9
                                  : ColorUtils.black92.withOpacity(0.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => con.changeTab(1),
                      child: Container(
                        child: Column(
                          children: [
                            Spacer(),
                            Container(
                              width: 40.w,
                              child: Center(
                                child: AdoroText(
                                  "Mentions",
                                  fontWeight: FontWeightClass.fontWeight700,
                                  color: con.tabIndex == 1
                                      ? ColorUtils.blueB9
                                      : black92White,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 0.5.w,
                              width: 40.w,
                              color: con.tabIndex == 1
                                  ? ColorUtils.blueB9
                                  : ColorUtils.black92.withOpacity(0.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizeConfig.sH2,
              con.tabIndex == 0
                  ? Container(
                      width: 90.w,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: profile.posts?.length ?? 0,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 3.2.w,
                          crossAxisSpacing: 3.2.w,
                        ),
                        itemBuilder: (c, index) {
                          final post = profile.posts![index];
                          return InkWell(
                            onTap: () => Get.to(
                              () => ShowPost(
                                index: index,
                                postList: profile.posts ?? [],
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1.5.w),
                              child: post.contentType!.toLowerCase() == 'video'
                                  ? Container(
                                      color: black92White!.withOpacity(0.5),
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        size: 10.w,
                                        color: whiteBlack2E,
                                      ),
                                    )
                                  : Image.network(
                                      post.contentUrl ?? '',
                                      fit: BoxFit.fill,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress != null) {
                                          return Center(
                                              child:
                                                  CupertinoActivityIndicator());
                                        }
                                        return child;
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Icon(Icons.error_outline),
                                        );
                                      },
                                    ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      width: 90.w,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: profile.mention?.length ?? 0,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 3.2.w,
                          crossAxisSpacing: 3.2.w,
                        ),
                        itemBuilder: (c, index) {
                          return InkWell(
                            onTap: () => Get.to(
                              () => ShowMentions(
                                index: index,
                                // mentionsList: [],
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1.5.w),
                              child: Image.network(
                                '',
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
