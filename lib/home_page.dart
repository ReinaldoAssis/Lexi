// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  bool extended_feed = false;

  @override
  void initState() {
    super.initState();
    scroller = ScrollController();
    scroller.addListener(scroll);
  }

  @override
  void dispose() {
    scroller.removeListener(scroll);
    scroller.dispose();
    super.dispose();
  }

  void scroll() {
    ScrollDirection dir = scroller.position.userScrollDirection;

    if (dir == ScrollDirection.forward) {
      setState(() {
        extended_feed = false;
      });
    } else if (dir == ScrollDirection.reverse) {
      setState(() {
        extended_feed = true;
      });
    }
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
            height: extended_feed ? 10 : 30,
          ),

          ContinueReading(
            scroller: scroller,
          ),

          //************** */

          HomeFeed(
            h: h,
            scroller: scroller,
          ),
        ],
      ),
    );
  }
}

class HomeFeed extends StatefulWidget {
  const HomeFeed({
    Key? key,
    required this.scroller,
    required this.h,
  }) : super(key: key);

  final double h;
  final ScrollController scroller;

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  bool extended_feed = false;

  @override
  void initState() {
    super.initState();
    widget.scroller.addListener(scroll);
  }

  @override
  void dispose() {
    widget.scroller.dispose();
    super.dispose();
  }

  void scroll() {
    ScrollDirection dir = widget.scroller.position.userScrollDirection;

    if (dir == ScrollDirection.forward) {
      setState(() {
        extended_feed = false;
      });
    } else if (dir == ScrollDirection.reverse) {
      setState(() {
        extended_feed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: extended_feed ? 73 * widget.h : 48 * widget.h,
      padding: EdgeInsets.only(top: (extended_feed ? 0 : 10)),
      child: ListView(controller: widget.scroller, children: [
        UnderlineText(
          text: "Library",
        ),

        SizedBox(
          height: 15,
        ),

        //*************** */

        Container(
          height: 32 * widget.h,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...Mangas.map((e) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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

        ...List.generate(
            (Mangas.length / 2).round(),
            (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MangaCover(Mangas[i]),
                      MangaCover(Mangas[i + 1])
                    ],
                  ),
                ))

        // Container(
        //   height: 60 * widget.h,
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: ListView(
        //     children: [
        //       ...Mangas.map((e) => Padding(
        //           padding:
        //               const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        //           child: MangaCover(
        //             e,
        //           ))),
        //     ],
        //   ),
        // ),
      ]),
    );
  }
}
