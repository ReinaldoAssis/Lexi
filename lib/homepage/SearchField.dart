// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key, this.hintText = "Search mangas"})
      : super(key: key);

  final String hintText;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Container(
      width: _width * 0.8,
      height: _height * 0.09,
      child: TextField(
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 219, 219, 219), width: 2)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(color: Colors.black, width: 2)),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 5),
              child: Icon(
                Icons.search,
                color: Colors.grey,
                size: 33,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
