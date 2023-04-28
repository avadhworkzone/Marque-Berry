// ignore_for_file: must_be_immutable

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
import '../../commanWidget/common_image.dart';
import '../../model/apiModel/responseModel/post_comment_res_model.dart';
import '../../model/apis/api_response.dart';
import '../../utils/assets/images_utils.dart';
import '../../viewModel/category_view_model.dart';

class Comments extends StatelessWidget {
  int? postId = 0;
  int? likeCount;
  String profileImage = "";

  Comments({
    Key? key,
    this.likeCount,
    required this.postId,
    required this.profileImage,
  }) : super(key: key);

  CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();

  PostCommentReqModel postCommentReqModel = PostCommentReqModel();

  postCommentApiCall() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await categoryFeedViewModel.getAllComments(postId.toString());
    });
  }

  ScrollController scrollController = ScrollController();

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;

    var commentTextEditing = TextEditingController();

    return Material(
      child: GetBuilder<HomeController>(builder: (home) {
        return GetBuilder<CategoryFeedViewModel>(
          initState: (_) {
            postCommentApiCall();
          },
          builder: (categoryFeedViewModel) {
            if (categoryFeedViewModel.getAllCommentApiResponse.status ==
                    Status.LOADING ||
                categoryFeedViewModel.getAllCommentApiResponse.status ==
                    Status.INITIAL)
              return Center(child: Loader());
            else if (categoryFeedViewModel.getAllCommentApiResponse.status ==
                Status.ERROR) return SomethingWentWrong();

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
                    onTap: () => Get.back(),
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
                      itemCount: response.data
                              ?.where((element) => element.parentId == "0")
                              .toList()
                              .length ??
                          0,
                      itemBuilder: (context, index) {
                        final commentData = response.data![index];

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (commentData.parentId == "0")
                                CommentList(
                                  likecount: (likeCount ?? 0).toString(),
                                  replaycount: 0,
                                  time: postTimeCalculate(
                                    commentData.createdOn.toString(),
                                    '',
                                  ),
                                  replayMessage: () {
                                    commentTextEditing.text =
                                        "@${commentData.username} ";

                                    /// main comment
                                    home.parentCommentIdChange(
                                      commentData.commentId.toString(),
                                    );

                                    FocusScope.of(context)
                                        .requestFocus(focusNode);
                                    commentTextEditing.selection =
                                        TextSelection.fromPosition(
                                      TextPosition(
                                        offset: commentTextEditing.text.length,
                                      ),
                                    );
                                  },
                                  name: commentData.username ?? "",
                                  img: commentData.image ?? "",
                                  mentione: '',
                                  replayData: false,
                                  message: commentData.comment ?? "",
                                ),
                              for (int i = 0;
                                  i < commentData.childComment!.length;
                                  i++)
                                Container(
                                  width: 80.w,
                                  padding: EdgeInsets.only(top: 5.w),
                                  child: CommentList(
                                    replayMessage: () {
                                      /// sub comment
                                      home.parentCommentIdChange(
                                          commentData.commentId.toString());

                                      commentTextEditing.text =
                                          "@${commentData.childComment?[i].username} ";
                                      FocusScope.of(context)
                                          .requestFocus(focusNode);

                                      commentTextEditing.selection =
                                          TextSelection.fromPosition(
                                        TextPosition(
                                            offset:
                                                commentTextEditing.text.length),
                                      );
                                    },
                                    likecount: (likeCount ?? 0).toString(),
                                    replaycount: 0,
                                    time: postTimeCalculate(
                                      commentData.childComment?[i].createdOn,
                                      '',
                                    ),
                                    name:
                                        commentData.childComment?[i].username ??
                                            "",
                                    img: commentData.childComment?[i].image ??
                                        "",
                                    mentione: '',
                                    replayData: true,
                                    message:
                                        commentData.childComment?[i].comment ??
                                            "",
                                  ),
                                ),

                              // if (subComments.length > 0)
                              //   Column(
                              //     children: List.generate(
                              //       subComments.length,
                              //       (subIndex) => Container(
                              //         width: 80.w,
                              //         padding: EdgeInsets.only(top: 5.w),
                              //         child: CommentList(
                              //           likecount: (likecount ?? 0).toString(),
                              //           replaycount: 0,
                              //           time: "2 W ago",
                              //           name: subComments[subIndex].username ??
                              //               "",
                              //           img: subComments[subIndex].image ?? "",
                              //           mentione: '',
                              //           replayData: false,
                              //           message:
                              //               subComments[subIndex].comment ?? "",
                              //         ),
                              //       ),
                              //     ),
                              //   ),
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
                            backgroundColor: Colors.grey[100],
                            backgroundImage: NetworkImage(profileImage),
                            onBackgroundImageError: (_, __) {
                              CommonImage(
                                img: IconsWidgets.userImages,
                                color: ColorUtils.black,
                              );
                            },
                          ),
                          SizeConfig.sW3,
                          Expanded(
                            child: CommonTextFormField(
                              focusNode: focusNode,
                              textstyle: TextStyle(color: blackWhite),
                              validator: (v) => emptyValidation(v),
                              color: blackWhite,
                              hintText: 'write a comment...',
                              hintStyle: TextStyle(
                                color: ColorUtils.black92,
                                fontSize: 12.sp,
                              ),
                              controller: commentTextEditing,
                              denyInput: false,
                              denyInputFormatters: RegularExpression
                                  .onlyFirstSpaceNoAllowPattern,
                              allowInputFormatters:
                                  RegularExpression.allKeyboardPattern,
                            ),
                          ),
                          SizeConfig.sW1,
                          TextButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (commentTextEditing.text.isEmpty) {
                                showSnackBar(message: 'Field is required');
                                return;
                              }
                              postCommentReqModel.parentId =
                                  (home.parentId).toString();
                              postCommentReqModel.postId = postId.toString();
                              postCommentReqModel.comment =
                                  commentTextEditing.text;
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
                                commentTextEditing.clear();

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
}
