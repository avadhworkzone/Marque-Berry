import 'package:flutter/material.dart';

import '../../utils/tecell_text.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: AdoroText("HOME"),
      ),
    );
  }
}
