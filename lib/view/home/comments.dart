import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/requestModel/post_comment_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/get_all_comment_res_model.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/custom_text_field.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/validation_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/home/comment_components/comment_list_components.dart';
import 'package:socialv/view/home/home.dart';

import '../../commanWidget/common_appbar.dart';
import '../../model/apiModel/responseModel/post_comment_res_model.dart';
import '../../model/apis/api_response.dart';
import '../../viewModel/category_view_model.dart';

class Comments extends StatelessWidget {
  String postId;
  int? likecount;

  Comments({Key? key, required this.postId, this.likecount}) : super(key: key);

  CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();

  PostCommentReqModel postCommentReqModel = PostCommentReqModel();

  postCommentApiCall() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await categoryFeedViewModel.getAllComments(postId);
    });
  }

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Color? canvasColor = Theme.of(context).canvasColor;

    return Material(
      color: canvasColor,
      child: GetBuilder<HomeController>(builder: (home) {
        return GetBuilder<CategoryFeedViewModel>(
          initState: (_) {
            postCommentApiCall();
          },
          builder: (categoryFeedViewModel) {
            if (categoryFeedViewModel.getAllCommentApiResponse.status ==
                    Status.LOADING ||
                categoryFeedViewModel.getAllCommentApiResponse.status ==
                    Status.INITIAL) {
              return Center(child: Loader());
            } else if (categoryFeedViewModel.getAllCommentApiResponse.status ==
                Status.ERROR) {
              return SomethingWentWrong();
            }

            GetAllCommentResModel response =
                categoryFeedViewModel.getAllCommentApiResponse.data;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PreferredSize(
                  preferredSize: Size.fromHeight(22.w),
                  child: CommonAppBar(
                    title: 'Comments',
                    ontap: () => Get.back(),
                  ),
                ),
                if (response.status.toString() == VariableUtils.status500)
                  Expanded(
                    child: Center(
                      child: AdoroText(
                        response.msg ?? VariableUtils.somethingWentWrong,
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: response.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final commentdata = response.data![index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CommentList(
                                likecount: (likecount ?? 0).toString(),
                                replaycount: 0,
                                time: "2 W ago",
                                name: commentdata.username ?? "",
                                img: commentdata.image ?? "",
                                mentione: '',
                                replayData: false,
                                message: commentdata.comment ?? "",
                              ),
                              SizeConfig.sH1,
                              DecorationUtils.dividerLine2(),
                              SizeConfig.sH1,
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    height: 18.w,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: ColorUtils.black.withOpacity(0.5),
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    // color: ColorUtils.red29,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 6.w,
                            child: Image.asset(
                              "assets/icons/user4.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizeConfig.sW3,
                          Expanded(
                            child: CommonTextFormField(
                              validator: (v) => emptyValidation(v),
                              color: Colors.black,
                              hintText: 'write a comment...',
                              hintStyle: TextStyle(
                                color: ColorUtils.black92,
                                fontSize: 12.sp,
                              ),
                              controller: commentController,
                              denyInputFormatters: RegularExpression
                                  .onlyFirstSpaceNoAllowPattern,
                              allowInputFormatters:
                                  RegularExpression.nameKeyboardPattern,
                            ),
                          ),
                          SizeConfig.sW1,
                          TextButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (commentController.text.isEmpty) {
                                showSnackBar(message: 'Field is required');
                                return;
                              }
                              logs("postId:=====> $postId");
                              postCommentReqModel.parentId =
                                  (home.parentId ?? 0).toString();
                              postCommentReqModel.postId = postId;
                              postCommentReqModel.comment =
                                  commentController.text;
                              await categoryFeedViewModel
                                  .postComments(postCommentReqModel);
                              if (categoryFeedViewModel
                                      .postCommentApiResponse.status ==
                                  Status.COMPLETE) {
                                PostCommentResModel postCommentRes =
                                    categoryFeedViewModel
                                        .postCommentApiResponse.data;
                                showSnackBar(
                                  message: postCommentRes.msg ??
                                      "Post updated successfully",
                                  snackbarSuccess: true,
                                );
                                postCommentApiCall();
                                commentController.clear();

                                scrollController.animateTo(
                                  scrollController.position.maxScrollExtent +
                                      150,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              }
                            },
                            child: AdoroText('Reply', color: ColorUtils.blueB9),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      }),
    );
  }

  var commentController = TextEditingController();
  //
  // List<Map<String, dynamic>> commentsList = [
  //   {
  //     "likecount": "19",
  //     "replaycount": 0,
  //     "time": "8 min ago",
  //     "name": 'Jane_Cooper',
  //     "img": "assets/icons/user1.png",
  //     "mentione": "@ira_membrit",
  //     "replayData": false,
  //     "message":
  //         'Loving 😍 your work and profile 👨 Top Marks. Once you are confident enough to develop',
  //   },
  //   {
  //     "img": "assets/icons/user2.png",
  //     "name": 'con Trariweis',
  //     "time": "6 min ago",
  //     "message": 'Nice 👌 Work, love your content ',
  //     "likecount": "19",
  //     "replaycount": 1,
  //     "mentione": '',
  //     "replayData": false,
  //   },
  // ];
}

/// device show kar
/// done ok
