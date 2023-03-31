import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class Note extends StatelessWidget {
  const Note({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _bulidBody();
  }

  Scaffold _bulidBody() {
    return Scaffold(
      appBar: customAppbar('Note'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                AdoroText("• ", fontSize: 30, color: ColorUtils.black92),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: AdoroText(
                        'fghssk shjskdkdddjkh dksshjdjkk gfhdjjs hdhdj sjjsjs jhsjsjs hsjsj ythjfui hdjdj dyddidu yduud',
                        color: ColorUtils.black92,
                        fontSize: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 190,
              width: 300,
              color: ColorUtils.note,
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/playmusic.png',
                  scale: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
