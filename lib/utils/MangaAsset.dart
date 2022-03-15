import 'package:flutter/material.dart';

class MangaAsset {
  final String url;
  final String title;

  final int totalChapters;
  final int readChapters;
  final int lastRead;

  MangaAsset(
      {this.title = "nul",
      this.readChapters = 0,
      this.totalChapters = 0,
      this.lastRead = 0,
      this.url = "nul"});

  DecorationImage Render() {
    return DecorationImage(image: NetworkImage(url), fit: BoxFit.cover);
  }

  double GetProgress() {
    return 100 * (readChapters / totalChapters);
  }
}
