import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/variable_utils.dart';

class CustomImageCrop extends StatefulWidget {
  final String img;

  CustomImageCrop({Key? key, required this.img}) : super(key: key);

  @override
  State<CustomImageCrop> createState() => _CustomImageCropState();
}

class _CustomImageCropState extends State<CustomImageCrop> {
  final cropKey = GlobalKey<CropState>();
  int selectedIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        bottomNavigationBar: customBottomSheet(),
        body: Stack(
          children: [
            _buildCropImage(),
            if (selectedIndex == 0)
              Container(
                  width: Get.width,
                  height: Get.height,
                  color: ColorUtils.black,
                  child: Center(
                      child: Image.file(
                    File(
                      widget.img,
                    ),
                  ))),
          ],
        ));
  }

  Container customBottomSheet() {
    return Container(
      height: 70,
      width: Get.width,
      color: ColorUtils.darkBlue3A,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              icon: Icon(
                Icons.crop,
                color: selectedIndex == 1
                    ? ColorUtils.linearGradient1
                    : ColorUtils.white,
                size: 30,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              icon: Icon(
                Icons.all_out_sharp,
                color: selectedIndex == 0
                    ? ColorUtils.linearGradient1
                    : ColorUtils.white,
                size: 30,
              ))
        ],
      ),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorUtils.white,
      // title: Text(
      //   VariableUtils.cropper,
      //   style: TextStyle(color: ColorUtils.black),
      // ),
      leading: IconButton(
        icon: Icon(Icons.clear, color: ColorUtils.black),
        onPressed: () {
          Get.back();
        },
      ),
      actions: [
        isLoading
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CupertinoActivityIndicator())
            : IconButton(
                onPressed: () {
                  if (selectedIndex == 0) {
                    Get.back(result: widget.img);
                  } else {
                    _cropImage();
                  }
                },
                icon: Icon(
                  Icons.check,
                  color: ColorUtils.black,
                ))
      ],
    );
  }

  Widget _buildCropImage() {
    return Container(
      color: Colors.black,
      width: Get.width,
      height: Get.height,
      padding: const EdgeInsets.all(20.0),
      child: Crop(
        key: cropKey,
        image: FileImage(File(widget.img)),
        // aspectRatio: 4.0 / 3.0,
      ),
    );
  }

  void setIsLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  Future<void> _cropImage() async {
    try {
      setIsLoading(true);
      final scale = cropKey.currentState!.scale;
      final area = cropKey.currentState!.area;
      if (area == null) {
        setIsLoading(false);
        if (mounted == false) {
          return;
        }
        Get.back(result: widget.img);

        return;
      }

      final sample = await ImageCrop.sampleImage(
        file: File(widget.img),
        preferredSize: (2000 / scale).round(),
      );

      final file = await ImageCrop.cropImage(
        file: sample,
        area: area,
      );
      if (mounted == false) {
        return;
      }
      setIsLoading(false);
      sample.delete();

      Get.back(result: file.path);

      debugPrint('$file');
    } on Exception catch (e) {
      setIsLoading(false);
      Get.back(result: widget.img);
    }
  }
}
