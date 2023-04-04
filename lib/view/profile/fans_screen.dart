import 'package:flutter/material.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

import '../../commanWidget/common_appbar.dart';

class FansScreen extends StatelessWidget {
  const FansScreen({Key? key}) : super(key: key);
  final isCheck = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppbar(
        title: 'Fans',
        icon: const Icon(
          Icons.search_rounded,
          color: ColorUtils.black2E,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 100,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorUtils.linearGradient1,
                  ColorUtils.linearGradient6,
                  ColorUtils.linearGradient7
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            // padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(bottom: 630),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AdoroText(
                  color: ColorUtils.blueE7,
                  'Following'.toUpperCase(),
                ),
                AdoroText(
                  color: ColorUtils.white,
                  'Followers'.toUpperCase(),
                ),
              ],
            ),
          ),
          Positioned(
            top: 60,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtils.white),
              height: size.height,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    AdoroText('Fans'.toUpperCase(),
                        color: ColorUtils.black2E, fontWeight: FontWeight.bold),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                              children: [
                                const Text(
                                  'jane_ui Ux',
                                  style: TextStyle(color: ColorUtils.black2E),
                                ),
                                Checkbox(value: isCheck, onChanged: (value) {})
                              ],
                            ),
                            subtitle: const Text(
                              '@ jane_copper',
                              style: TextStyle(color: ColorUtils.black92),
                            ),
                            leading: CircleAvatar(
                              child: Image.asset('assets/images/Profile1.png'),
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
        ],
      ),
    );
  }
}
