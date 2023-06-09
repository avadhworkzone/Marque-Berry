import 'package:flutter/material.dart';

class HomeText extends StatelessWidget {
  const HomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // backgroundColor: Colors.grey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Image(
                height: 50,
                width: 50,
                image: AssetImage(
                  "assets/images/text.png",
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text("Likenootherwa",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // height: 400,
            width: double.maxFinite,
            color: Colors.red,
            child: Image(
              fit: BoxFit.fitHeight,
              image: AssetImage(
                "assets/images/text.png",
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Likenootherwa Join a diverse.....")
        ],
      ),
    );
  }
}
