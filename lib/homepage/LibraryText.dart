import 'package:flutter/material.dart';

class UnderlineText extends StatelessWidget {
  const UnderlineText({Key? key, this.text = "oi", this.width = 88})
      : super(key: key);

  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 34,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            color: Colors.black,
            width: width,
            height: 3,
          )
        ],
      ),
    );
  }
}
