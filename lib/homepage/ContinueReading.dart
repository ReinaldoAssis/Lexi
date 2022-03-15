// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lexi/colors.dart';
import 'package:lexi/components/ProgressBar.dart';
import 'package:lexi/utils/MangaAsset.dart';

import '../utils/Dummydata.dart';

class ContinueReading extends StatefulWidget {
  const ContinueReading({Key? key}) : super(key: key);

  @override
  State<ContinueReading> createState() => _ContinueReadingState();
}

class _ContinueReadingState extends State<ContinueReading> {
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
        Container(
          padding: const EdgeInsets.only(top: 7, left: 160, right: 10),
          alignment: Alignment.center,
          width: w * 90,
          height: h * 24,
          decoration: BoxDecoration(
              boxShadow: Homecolor.SombraMor, color: Colors.grey[300]),
          child: Column(
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
        ),
        Positioned(
          top: -h * 2,
          left: w * 5,
          child: Container(
            width: aspectW,
            height: aspectH,
            decoration: BoxDecoration(
                boxShadow: Homecolor.Sombra,
                color: Colors.grey,
                image: Mangas[0].Render()),
          ),
        )
      ],
    );
  }
}
