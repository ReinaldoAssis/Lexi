// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lexi/colors.dart';
import 'package:lexi/utils/MangaAsset.dart';
import 'package:sizer/sizer.dart';

class MangaCover extends StatelessWidget {
  MangaCover(this.manga, {Key? key}) : super(key: key);

  MangaAsset manga;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width / 100;
    double _h = MediaQuery.of(context).size.height / 100;

    double hxh = 10;
    double wxw = 7;

    double aspectW = (_h * wxw) / hxh * 24;
    double aspectH = (aspectW * hxh) / wxw;

    String modTitle = manga.title.length > 10
        ? (manga.title.substring(0, 10) + "...")
        : manga.title;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: aspectW,
          height: aspectH,
          decoration: BoxDecoration(
              //color: Color.fromARGB(255, 104, 104, 104),
              boxShadow: Homecolor.SombraMor,
              image: DecorationImage(image: NetworkImage(manga.url)),
              borderRadius: BorderRadius.all(Radius.circular(6))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Text(
            //widget.title == "nul" ? "" : widget.title,
            modTitle,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
