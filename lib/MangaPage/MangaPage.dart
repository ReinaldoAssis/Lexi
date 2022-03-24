// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lexi/components/FloatingNavBar.dart';

class MangaPage extends StatefulWidget {
  const MangaPage({Key? key}) : super(key: key);

  @override
  State<MangaPage> createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: FloatingNavBar(scroller: new ScrollController()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          "Manga",
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
