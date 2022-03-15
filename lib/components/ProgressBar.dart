import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar(
      {Key? key,
      this.width = 50,
      this.height = 1.1,
      this.fillcolor = Colors.green,
      this.radius = 20,
      this.percentage = 0})
      : super(key: key);

  final double width;
  final double height;
  final Color fillcolor;
  final Color color = Color.fromARGB(255, 172, 172, 172);
  final double radius;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 100;
    double h = MediaQuery.of(context).size.height / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          children: [
            Container(
              width: w * width,
              height: h * height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                  color: color),
            ),
            Container(
              width: w * width * percentage / 100,
              height: h * height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                  color: fillcolor),
            )
          ],
        ),
        Text(
          '${percentage.round()}% completed',
          style: TextStyle(fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
