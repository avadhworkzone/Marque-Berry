import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar('Results'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 11,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdoroText("• ",
                            color: index == 0
                                ? ColorUtils.grey
                                : ColorUtils.result,
                            fontSize: 30),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: AdoroText(
                            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.',
                            color: ColorUtils.black92,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
