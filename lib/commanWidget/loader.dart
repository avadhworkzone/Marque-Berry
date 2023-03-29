import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({Key? key, this.isExpand}) : super(key: key);
  final bool? isExpand;

  @override
  Widget build(BuildContext context) {
    return isExpand == true
        ? SizedBox(
            height: Get.height,
            width: Get.width,
            child: Lottie.asset('assets/lotties/loading.json', width: 20.w),
          )
        : Lottie.asset('assets/lotties/loading.json', width: 20.w);
  }
}

class ServerError extends StatelessWidget {
  const ServerError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: AdoroText(VariableUtils.serverError));
  }
}

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: AdoroText(VariableUtils.noDataFound));
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: AdoroText(VariableUtils.somethingWentWrong));
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: LottieWidgts.loaderPrimary);
  }
}

class TryAfterSomeTime extends StatelessWidget {
  const TryAfterSomeTime({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdoroText(VariableUtils.tryAfterSomeTime);
  }
}
