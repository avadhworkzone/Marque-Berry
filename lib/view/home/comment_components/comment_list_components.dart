// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/model/apiModel/requestModel/update_comment_req_model.dart';
import 'package:socialv/utils/custom_text_field.dart';
import 'package:socialv/utils/validation_utils.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:socialv/view/home/comment_components/replay_button.dart';
import 'package:socialv/view/home/comment_components/like_components.dart';
import 'package:socialv/model/apiModel/requestModel/delete_comment_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/common_status_msg_res_model.dart';

import '../../../model/apis/api_response.dart';
import '../../profile/profile.dart';

class CommentList extends StatefulWidget {
  String img;
  String time;
  String name;
  String message;
  String likeCount;
  int replayCount = 0;
  int commentId = 0;
  int userId = 0;
  VoidCallback replayMessage;
  VoidCallback likeOnTap;
  CategoryFeedViewModel categoryFeedViewModel;
  HomeController homeController;
  int postId;
  bool isLiked;

  CommentList(
      {Key? key,
      required this.img,
      required this.postId,
      required this.commentId,
      required this.name,
      required this.time,
      required this.message,
      required this.likeCount,
      required this.userId,
      required this.replayCount,
      required this.replayMessage,
      required this.categoryFeedViewModel,
      required this.homeController,
      required this.isLiked,
      required this.likeOnTap
      // required this.updateCallBack,
      })
      : super(key: key);

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,

                onTap: () {
                  Get.to(() => Profile(
                    // userId: widget.commentId,
                    userId: widget.userId,
                  ));
                },
                leading: CircleAvatar(
                  radius: 6.w,
                  backgroundColor: Colors.grey[100],
                  backgroundImage: NetworkImage(widget.img),
                  onBackgroundImageError: (_, __) {
                    CommonImage(
                      img: IconsWidgets.userImages,
                      color: blackWhite,
                    );
                  },
                ),
                title: AdoroText(
                  "${widget.name}",
                  maxLines: 1,
                  fontSize: 13.sp,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeightClass.fontWeight700,
                  color: blackWhite,
                ),
                trailing: AdoroText(
                  "${widget.time}",
                  fontSize: 10.sp,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: InkWell(
                    onTap: () {
                      editDeleteBottomSheet(
                        message: widget.message,
                        categoryFeedViewModel: widget.categoryFeedViewModel,
                        commentId: widget.commentId,
                        context: context,
                      );
                    },
                    child: SizedBox(width: Get.width,child: CommentDescription(message: widget.message))),
              ),
            ],
          ),
          Row(
            children: [
              SizeConfig.sW2,
              InkWell(
                  onTap: widget.likeOnTap,
                  child: LikeButton(
                      likecounter: widget.likeCount, isLiked: widget.isLiked)),
              SizeConfig.sW2,
              InkWell(
                onTap: () => widget.replayMessage(),
                child: ReplayButton(replaycount: widget.replayCount),
              ),
            ],
          ),
        ],
      ),
    );
  }

  DeleteCommentReqModel deleteCommentReqModel = DeleteCommentReqModel();

  editDeleteBottomSheet({
    required int commentId,
    required String message,
    required BuildContext context,
    required CategoryFeedViewModel categoryFeedViewModel,
  }) {
    Get.bottomSheet(
      Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.w),
                topRight: Radius.circular(5.w),
              ),
              color: ColorUtils.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                    updateTextEditing.text = message;
                    // updateTextEditing.selection = TextSelection.fromPosition(
                    //   TextPosition(
                    //     offset: updateTextEditing.text.length,
                    //   ),
                    // );
                    setState(() {});
                    updateFromBottomSheet(context, commentId);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(onPressed: null, icon: Icon(Icons.edit)),
                      AdoroText("Edit comment",
                          color: ColorUtils.black92, fontSize: 13.sp),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    deleteCommentReqModel.id = commentId.toString();

                    await categoryFeedViewModel
                        .deleteComment(deleteCommentReqModel);

                    if (categoryFeedViewModel.deleteCommentApiResponse.status ==
                        Status.COMPLETE) {
                      CommonStatusMsgResModel response =
                          categoryFeedViewModel.deleteCommentApiResponse.data;
                      if (response.status.toString() ==
                          VariableUtils.status200) {
                        postCommentApiCall(widget.homeController);
                        Get.back();
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.delete),
                      ),
                      AdoroText(
                        "Delete comment",
                        color: ColorUtils.black92,
                        fontSize: 13.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  updateFromBottomSheet(context, commentId) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Get.bottomSheet(
      Container(
        color: ColorUtils.white,
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.all(3.w),
              child: Row(
                children: [
                  Expanded(
                    child: CommonTextFormField(
                      textstyle: TextStyle(color: blackWhite),
                      validator: (v) => emptyValidation(v),
                      color: blackWhite,
                      hintText: 'write a comment...',
                      hintStyle: TextStyle(
                        color: ColorUtils.black92,
                        fontSize: 12.sp,
                      ),
                      controller: updateTextEditing,
                      denyInput: false,
                      denyInputFormatters:
                          RegularExpression.onlyFirstSpaceNoAllowPattern,
                    ),
                  ),
                  SizeConfig.sW1,
                  TextButton(
                    onPressed: () async {
                      await updateComment(commentId, context);
                      postCommentApiCall(widget.homeController);
                    },
                    child: AdoroText('Reply', color: ColorUtils.blueB9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  postCommentApiCall(HomeController homeController) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await widget.categoryFeedViewModel
          .getAllComments(widget.postId.toString());
      homeController.parentCommentIdChange('0');
    });
  }

  UpdateCommentReqModel updateCommentReqModel = UpdateCommentReqModel();

  var updateTextEditing = TextEditingController();

  updateComment(int commentId, BuildContext context) async {
    updateCommentReqModel.id = commentId.toString();
    updateCommentReqModel.comment = updateTextEditing.text;

    await widget.categoryFeedViewModel.updateComment(updateCommentReqModel);

    if (widget.categoryFeedViewModel.updateCommentApiResponse.status ==
        Status.COMPLETE) {
      CommonStatusMsgResModel response =
          widget.categoryFeedViewModel.updateCommentApiResponse.data;
      if (response.status.toString() == VariableUtils.status200) {
        Get.back();
      }
    }
  }
}

class CommentDescription extends StatelessWidget {
  final String message;

  CommentDescription({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = message.split(" ");

    return Wrap(
      children: data.map((e) {
        if (e.contains("@")) {
          return mentionsText(e);
        }
        return normalText(e);
      }).toList(),
    );
  }
}

Text mentionsText(message) => Text(
      '$message ',
      style: TextStyle(
        fontSize: 11.5.sp,
        color: ColorUtils.blueB9,
        fontWeight: FontWeightClass.fontWeight800,
      ),
    );

Text normalText(message) => Text(
      message,
      style: TextStyle(
        fontSize: 11.5.sp,
        color: ColorUtils.black92,
        fontWeight: FontWeightClass.fontWeight800,
      ),
    );
