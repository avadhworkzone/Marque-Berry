import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/model/apiModel/responseModel/category_res_model.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class LikeScreen extends StatelessWidget {
  List<LikedByPeople>? likeProfile;

  LikeScreen({Key? key, required this.likeProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? whiteBlack = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: customAppbar(
        title: 'Likes',
        context: context,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            decoration: BoxDecoration(
              color: whiteBlack,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  AdoroText(
                    'Likes',
                    color: blackWhite,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      itemCount: likeProfile?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: AdoroText(
                            likeProfile?[index].username ?? "",
                            color: blackWhite,
                            // style: TextStyle(color: ColorUtils.black2E),
                          ),
                          subtitle: AdoroText(
                            likeProfile?[index].fullName ?? "",
                            color: blackWhite,
                            // style: TextStyle(color: ColorUtils.black92),
                          ),
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
                                  likeProfile?[index].image ?? "",
                                ),
                                progressIndicatorBuilder: (context, progress) {
                                  double? value;
                                  var expectedBytes =
                                      progress?.expectedTotalBytes;
                                  if (progress != null &&
                                      expectedBytes != null) {
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
                                  color: ColorUtils.greyFA.withOpacity(0.2),
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
                          trailing: const Icon(
                            Icons.more_vert,
                            color: ColorUtils.black92,
                          ),
                          contentPadding: const EdgeInsets.all(10),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
