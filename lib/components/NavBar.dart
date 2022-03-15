import 'package:flutter/material.dart';

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 100;
    double h = MediaQuery.of(context).size.height / 100;

    return Container(
      width: 40 * w,
      height: 10 * h,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
    );
  }
}
