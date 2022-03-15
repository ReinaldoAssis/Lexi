import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  static Color primaria100 = const Color(0xFFFFF0D6);
  static Color primaria200 = const Color(0xFFFFDEAD);
  static Color primaria300 = const Color(0xFFFFC684);
  static Color primaria400 = const Color(0xFFFFAF66);
  static Color primaria500 = const Color(0xFFFFAF66);
  static Color primaria600 = const Color(0xFFDB6825);
  static Color primaria700 = const Color(0xFFB74B19);
  static Color primaria800 = const Color(0xFF7A2009);

  static Color success100 = const Color(0xFFF3FDD4);
  static Color success200 = const Color(0xFFE3FCAA);
  static Color success300 = const Color(0xFFCEF87F);
  static Color success400 = const Color(0xFFB7F15E);
  static Color success500 = const Color(0xFF96E82C);
  static Color success600 = const Color(0xFF77C720);
  static Color success700 = const Color(0xFF5BA716);
  static Color success800 = const Color(0xFF42860E);

  static Color info100 = const Color(0xFFD1FEFF);
  static Color info200 = const Color(0xFFA3F7FF);
  static Color info300 = const Color(0xFF75EAFF);
  static Color info400 = const Color(0xFF52D9FF);
  static Color info500 = const Color(0xFF19BDFF);
  static Color info600 = const Color(0xFF1293DB);
  static Color info700 = const Color(0xFF0C6FB7);
  static Color info800 = const Color(0xFF074F93);

  static Color aviso100 = const Color(0xFFFEF6CD);
  static Color aviso200 = const Color(0xFFFEEB9C);
  static Color aviso300 = const Color(0xFFFEDC6B);
  static Color aviso400 = const Color(0xFFFDCE46);
  static Color aviso500 = const Color(0xFFFCB70A);
  static Color aviso600 = const Color(0xFFD89607);
  static Color aviso700 = const Color(0xFFB57805);
  static Color aviso800 = const Color(0xFF925C03);

  static Color neutro100 = Color.fromRGBO(158, 158, 158, 1);
  static Color neutro200 = Color.fromRGBO(100, 100, 100, 1);
  static Color neutro300 = Color.fromRGBO(64, 64, 64, 1);
  static Color neutro400 = Color.fromRGBO(30, 30, 30, 1);
  static Color neutro500 = Color.fromRGBO(10, 10, 10, 1);
  static Color neutro0 = Color.fromRGBO(0, 0, 0, 1);
}

class Palheta {
  static Color Petroleo = const Color(0xFF22272c);
  static Color PetroBlue = const Color(0xFF2a4158);
  static Color LightBlue = const Color(0xFF597387);
  static Color LightLight = const Color(0xFF8c9ea3);

  static Color RoxoLight = const Color(0xFFA8B1FE);
  static Color RoxoMed = const Color(0xFF6C63FF);
  static Color RoxoMed200 = Color.fromARGB(255, 94, 87, 214);

  // static LinearGradient FundoRoxo =
  //     const LinearGradient(colors: [Color(0xFFA8B1FE), Color(0xFF4D61FC)]);
}

class Homecolor {
  static Color PetroBlue = const Color(0xFF233974);
  static List<BoxShadow> Sombra = [
    BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: Offset(0, 2))
  ];

  static List<BoxShadow> SombraMor = [
    BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: Offset(0, 3))
  ];
}
