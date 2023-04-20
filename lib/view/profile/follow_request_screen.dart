import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class FollowRequestScreen extends StatelessWidget {
  const FollowRequestScreen({Key? key}) : super(key: key);
  final isCheck = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorUtils.note,
      appBar: customAppbar(
        context: context,
        title: 'Follow request',
        icon: const Icon(
          Icons.search_rounded,
          color: ColorUtils.black2E,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                color: ColorUtils.white,
              ),
              height: size.height / 1.1 - 39,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AdoroText(
                          'Follow request (10)',
                          color: ColorUtils.black2E,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        AdoroText(
                          'SEE All',
                          color: ColorUtils.black92,
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: ListView.builder(
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        'jane_ui Ux',
                                        style: TextStyle(
                                          color: ColorUtils.black2E,
                                        ),
                                      ),
                                      Icon(Icons.check_box
                                          // color: ColorUtils.blueF0,
                                          )
                                    ],
                                  ),
                                  subtitle: const Text(
                                    '@ jane_copper',
                                    style: TextStyle(color: ColorUtils.black92),
                                  ),
                                  leading: CircleAvatar(
                                    child: Image.asset(
                                        'assets/images/Profile1.png'),
                                  ),
                                  trailing: Wrap(
                                    spacing: 2,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Image.asset(
                                          'assets/images/TickSquare.png',
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Image.asset(
                                          'assets/images/CloseSquare.png',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider()
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
