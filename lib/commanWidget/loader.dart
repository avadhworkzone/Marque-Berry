import 'package:flutter/material.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';

// class CircularIndicator extends StatelessWidget {
//   const CircularIndicator({Key? key, this.isExpand}) : super(key: key);
//   final bool? isExpand;
//
//   @override
//   Widget build(BuildContext context) {
//     return isExpand == true
//         ? SizedBox(
//             height: Get.height,
//             width: Get.width,
//             child: Lottie.asset('assets/lotties/loading.json', width: 20.w),
//           )
//         : Lottie.asset('assets/lotties/loading.json', width: 20.w);
//   }
// }

class ServerError extends StatelessWidget {
  const ServerError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return AdoroText(VariableUtils.serverError, color: blackWhite);
  }
}

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return AdoroText(VariableUtils.noDataFound, color: blackWhite);
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return AdoroText(VariableUtils.somethingWentWrong, color: blackWhite);
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;

    return CircularProgressIndicator(color: blackWhite);
  }
}

class TryAfterSomeTime extends StatelessWidget {
  const TryAfterSomeTime({super.key});

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return AdoroText(VariableUtils.tryAfterSomeTime, color: blackWhite);
  }
}
