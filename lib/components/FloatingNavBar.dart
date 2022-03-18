import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lexi/colors.dart';

class FloatingNavBar extends StatefulWidget {
  FloatingNavBar({Key? key, required this.scroller}) : super(key: key);

  final ScrollController scroller;

  @override
  State<FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<FloatingNavBar> {
  int SelectedIndex = 0;
  List<IconData> icons = [Icons.home, Icons.download, Icons.settings];

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
        visible = false;
      });
    } else if (dir == ScrollDirection.reverse) {
      setState(() {
        visible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        AnimatedPositioned(
          width: MediaQuery.of(context).size.width,
          bottom: visible ? 0 : -90,
          duration: Duration(milliseconds: 200),
          child: Padding(
            padding: const EdgeInsets.only(right: 60, left: 60, bottom: 20),
            child: Container(
              height: 55,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(80), blurRadius: 6)
                  ]),
              clipBehavior: Clip.none,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: icons.length,
                  itemBuilder: (ctx, i) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              SelectedIndex = i;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(microseconds: 250),
                            width: 35,
                            decoration: BoxDecoration(
                              border: i == SelectedIndex
                                  ? Border(
                                      bottom: BorderSide(
                                          width: 3,
                                          color: Homecolor.PetroBlue100))
                                  : null,
                            ),
                            child: Icon(
                              icons[i],
                              size: 30,
                              color: i == SelectedIndex
                                  ? Homecolor.PetroBlue100
                                  : Colors.white,
                            ),
                          ),
                        ));
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
