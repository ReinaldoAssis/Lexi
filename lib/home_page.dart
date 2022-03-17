// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lexi/components/FloatingNavBar.dart';
import 'package:lexi/homepage/ContinueReading.dart';
import 'package:lexi/homepage/LibraryText.dart';
import 'package:lexi/homepage/MangaCover.dart';
import 'package:lexi/homepage/SearchField.dart';
import 'package:lexi/utils/Dummydata.dart';
import 'colors.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scroller;

  @override
  void initState() {
    super.initState();
    scroller = ScrollController();
  }

  @override
  void dispose() {
    scroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 100;
    double h = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: FloatingNavBar(scroller: scroller),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: ProfilePic,
                      minRadius: 22,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Text(
                        "ReizizII",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(child: Container()),
              Container(
                padding: const EdgeInsets.only(right: 30),
                child: Icon(
                  Icons.menu,
                  size: 33,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),

          //***************** */

          SearchField(),
          SizedBox(
            height: 30,
          ),

          ContinueReading(),

          //************** */

          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              height: 100 * h,
              child: ListView(controller: scroller, children: [
                UnderlineText(
                  text: "Library",
                ),

                SizedBox(
                  height: 15,
                ),

                //*************** */

                Container(
                  height: 35.h,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...Mangas.map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          child: MangaCover(
                            e,
                          ))),
                    ],
                  ),
                ),

                UnderlineText(
                  text: "Trending",
                  width: 115,
                ),

                SizedBox(
                  height: 15,
                ),

                Container(
                  height: 35.h,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...Mangas.map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          child: MangaCover(
                            e,
                          ))),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
