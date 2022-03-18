// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lexi/colors.dart';
import 'package:lexi/components/ProgressBar.dart';
import 'package:lexi/utils/MangaAsset.dart';

import '../utils/Dummydata.dart';

class ContinueReading extends StatefulWidget {
  const ContinueReading({Key? key, required this.scroller}) : super(key: key);

  final ScrollController scroller;

  @override
  State<ContinueReading> createState() => _ContinueReadingState();
}

class _ContinueReadingState extends State<ContinueReading> {
  bool visible = true;

  @override
  void initState() {
    super.initState();
    widget.scroller.addListener(scroll);
  }

  @override
  void dispose() {
    widget.scroller.removeListener(scroll);
    super.dispose();
  }

  void scroll() {
    ScrollDirection dir = widget.scroller.position.userScrollDirection;

    if (dir == ScrollDirection.forward) {
      setState(() {
        visible = true;
      });
    } else if (dir == ScrollDirection.reverse) {
      setState(() {
        visible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 100;
    double h = MediaQuery.of(context).size.height / 100;

    double hxh = 10;
    double wxw = 7;

    double aspectW = (h * wxw) / hxh * 24;
    double aspectH = (aspectW * hxh) / wxw;

    String modTitle = w * 100 > 500
        ? Mangas[0].title
        : Mangas[0].title.substring(0, 20) + "...";

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: visible ? 1 : 0,
          child: AnimatedScale(
            curve: Curves.easeOut,
            duration: Duration(milliseconds: 350),
            scale: visible ? 1 : 0,
            child: AnimatedContainer(
              curve: Curves.easeOut,
              duration: Duration(milliseconds: 450),
              padding: const EdgeInsets.only(top: 7, left: 160, right: 10),
              alignment: Alignment.center,
              width: w * 90,
              height: visible ? h * 24 : 0,
              decoration: BoxDecoration(
                  boxShadow: Homecolor.SombraMor, color: Colors.grey[300]),
              child: Wrap(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Continue reading",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.grey[500])),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Text(modTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: Colors.black)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Chapter ${Mangas[0].lastRead}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: w * 100 > 500 ? 10 : 15,
                      ),
                      ProgressBar(
                        percentage: Mangas[0].GetProgress(),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -h * 2,
          left: w * 5,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: visible ? 1 : 0,
            child: AnimatedScale(
              curve: Curves.easeOut,
              duration: Duration(milliseconds: 350),
              scale: visible ? 1 : 0,
              child: AnimatedContainer(
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 450),
                width: aspectW,
                height: visible ? aspectH : 0,
                decoration: BoxDecoration(
                    boxShadow: Homecolor.Sombra,
                    color: Colors.grey,
                    image: Mangas[0].Render()),
              ),
            ),
          ),
        )
      ],
    );
  }
}
