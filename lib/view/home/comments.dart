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
import 'package:socialv/utils/adoro_text.dart';
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

class Comments extends StatefulWidget {
  int? postId = 0;
  String profileImage = "";

  Comments({
    Key? key,
    required this.postId,
    required this.profileImage,
  }) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();

  PostCommentReqModel postCommentReqModel = PostCommentReqModel();

  postCommentApiCall(HomeController homeController) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await categoryFeedViewModel.getAllComments(widget.postId.toString());
      homeController.parentCommentIdChange('0');
    });
  }

  FocusNode focusNode = FocusNode();
  var commentTextEditing = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;

    return Material(
      child: GetBuilder<HomeController>(builder: (homeController) {
        return GetBuilder<CategoryFeedViewModel>(
          initState: (_) {
            categoryFeedViewModel.postCommentApiResponse=ApiResponse.initial('INITIAL');
            postCommentApiCall(homeController);
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
                  // Expanded(
                  //   child: Center(
                  //     child: AdoroText(
                  //       response.msg ?? VariableUtils.somethingWentWrong,
                  //
                  //     ),
                  //   ),
                  Expanded(child: SizedBox())
                else
                  Expanded(
                    child: SingleChildScrollView(
                      reverse: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: true,
                        physics: NeverScrollableScrollPhysics(),
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
                                    likeOnTap: () async {
                                      await categoryFeedViewModel
                                          .postLikeInComment(
                                              commentId: commentData.commentId
                                                  .toString(),
                                              postId: commentData.postId!,
                                              isLiked:
                                                  commentData.isLikedByMe ??
                                                      false);
                                      if (categoryFeedViewModel
                                              .postLikeInCommentApiResponse
                                              .status ==
                                          Status.COMPLETE) {
                                        postCommentApiCall(homeController);
                                      }
                                    },
                                    homeController: homeController,
                                    isLiked: commentData.isLikedByMe ?? false,
                                    categoryFeedViewModel:
                                        categoryFeedViewModel,
                                    likeCount: (commentData.likesCount ?? 0)
                                        .toString(),
                                    replayCount: 0,
                                    time: postTimeCalculate(
                                      commentData.createdOn.toString(),
                                      '',
                                    ),
                                    replayMessage: () {
                                      FocusScope.of(context)
                                          .requestFocus(focusNode);

                                      commentTextEditing.text =
                                          "@${commentData.username} ";
                                      setState(() {});

                                      /// main comment
                                      homeController.parentCommentIdChange(
                                        commentData.commentId.toString(),
                                      );

                                      commentTextEditing.selection =
                                          TextSelection.fromPosition(
                                        TextPosition(
                                          offset:
                                              commentTextEditing.text.length,
                                        ),
                                      );
                                    },
                                    name: commentData.username ?? "",
                                    img: commentData.image ?? "",
                                    message: commentData.comment ?? "",
                                    commentId: commentData.commentId ?? 0,
                                    postId: widget.postId ?? 0,
                                    userId: commentData.userId!,
                                  ),
                                for (int i = 0;
                                    i < commentData.childComment!.length;
                                    i++)
                                  Container(
                                    width: 80.w,
                                    padding: EdgeInsets.only(top: 5.w),
                                    child: CommentList(
                                      likeOnTap: () async {
                                        await categoryFeedViewModel
                                            .postLikeInComment(
                                                commentId: commentData
                                                    .childComment![i].commentId
                                                    .toString(),
                                                postId: commentData
                                                    .childComment![i].postId!,
                                                isLiked: commentData
                                                        .childComment![i]
                                                        .isLikedByMe ??
                                                    false);
                                        if (categoryFeedViewModel
                                                .postLikeInCommentApiResponse
                                                .status ==
                                            Status.COMPLETE) {
                                          postCommentApiCall(homeController);
                                        }
                                      },
                                      isLiked: commentData
                                              .childComment![i].isLikedByMe ??
                                          false,
                                      userId:
                                          commentData.childComment![i].userId!,
                                      commentId: commentData
                                              .childComment?[i].commentId ??
                                          0,
                                      postId: widget.postId ?? 0,
                                      categoryFeedViewModel:
                                          categoryFeedViewModel,
                                      replayMessage: () {
                                        /// sub comment
                                        FocusScope.of(context)
                                            .requestFocus(focusNode);

                                        homeController.parentCommentIdChange(
                                            commentData.commentId.toString());

                                        commentTextEditing.text =
                                            "@${commentData.childComment?[i].username} ";

                                        commentTextEditing.selection =
                                            TextSelection.fromPosition(
                                          TextPosition(
                                            offset:
                                                commentTextEditing.text.length,
                                          ),
                                        );
                                      },
                                      likeCount: (commentData.childComment![i]
                                                  .likesCount ??
                                              0)
                                          .toString(),
                                      replayCount: 0,
                                      time: postTimeCalculate(
                                        commentData.childComment?[i].createdOn,
                                        '',
                                      ),
                                      name: commentData
                                              .childComment?[i].username ??
                                          "",
                                      img: commentData.childComment?[i].image ??
                                          "",
                                      message: commentData
                                              .childComment?[i].comment ??
                                          "",
                                      homeController: homeController,
                                    ),
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
                            backgroundImage: NetworkImage(widget.profileImage),
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
                              // allowInputFormatters:
                              //     RegularExpression.allKeyboardPattern,
                            ),
                          ),
                          SizeConfig.sW1,
                          TextButton(
                            onPressed: () async {
                              if (categoryFeedViewModel
                                      .postCommentApiResponse.status ==
                                  Status.LOADING) {
                                return;
                              }
                              FocusScope.of(context).unfocus();
                              if (commentTextEditing.text.isEmpty) {
                                showSnackBar(message: 'Field is required');
                                return;
                              }
                              postCommentReqModel.parentId =
                                  (homeController.parentId).toString();
                              postCommentReqModel.postId =
                                  widget.postId.toString();
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

                                if (postCommentRes.status.toString() ==
                                    VariableUtils.status200) {
                                  postCommentApiCall(homeController);
                                  commentTextEditing.clear();
                                }
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
