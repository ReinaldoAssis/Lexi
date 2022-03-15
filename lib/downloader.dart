import "dart:io";
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class Downloader {
  static Downloader _instance = Downloader._internal();

  Downloader._internal() {
    _instance = this;
  }

  factory Downloader() => _instance;

  Future<String> _getAppPath() async {
    Directory dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> _file() async {
    final path = _getAppPath();
    return File('$path/teste.txt'); //HARD CODE NAME
  }

  Future<String> readTxtFile() async {
    File file = await _file();

    if (await file.exists()) {
      return await file.readAsString();
    }

    return "what the hell";
  }

  writeTxtFile(String content) async {
    File file = await _file();

    if (await file.exists()) await file.writeAsString(content);
  }
}
