import 'package:flutter/material.dart';
import 'package:socialv/utils/tecell_text.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(child: Center(child: AdoroText('PROFILE')));
  }
}
