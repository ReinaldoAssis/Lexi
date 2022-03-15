// ignore_for_file: unnecessary_new

import 'package:lexi/utils/MangaAsset.dart';
import 'package:flutter/material.dart';

List<MangaAsset> Mangas = [
  new MangaAsset(
      url:
          "https://external-preview.redd.it/7vog0MxcG-58TwkIEXC2lq0fcTMLXKaNPujdbxhYevw.jpg?auto=webp&s=b3d70fe4770ea10072ee47741d35ce62788e4970",
      title: "Magi: The Labyrinth of Magic",
      totalChapters: 500,
      readChapters: 355,
      lastRead: 355),
  new MangaAsset(
      url: "https://images-na.ssl-images-amazon.com/images/I/819gbwpjLcL.jpg",
      title: "Fullmetal Alchemist"),
  new MangaAsset(
      url:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeYhsKBucWZMEjVbGsFgRLzVsqQy8byr4e2w&usqp=CAU",
      title: "Chainsaw Man"),
  new MangaAsset(
      url:
          "https://i.pinimg.com/originals/55/53/4e/55534e752146014e5e5b0bcfbb767fa2.jpg",
      title: "Noragami"),
];

NetworkImage ProfilePic = new NetworkImage(
    "https://miro.medium.com/max/3840/1*hcZxr7HtQY3kfC89LbM2-g.jpeg");
