// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lexi/downloader.dart';
import 'colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Treino",
                    style: TextStyle(
                        fontSize: 30,
                        color: AppColor.neutro400,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: AppColor.neutro200,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.calendar_today_outlined,
                      size: 20, color: AppColor.neutro200),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: AppColor.neutro200,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(children: [
                Text(
                  "Seu programa",
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColor.neutro300,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Text(
                  "Detalhes",
                  style: TextStyle(
                      fontSize: 20,
                      color: Palheta.PetroBlue,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: AppColor.neutro400,
                )
              ]),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: BoxDecoration(
                    //color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(80)),
                    gradient: LinearGradient(
                        colors: [Palheta.Petroleo, Palheta.LightBlue],
                        begin: Alignment.bottomLeft,
                        end: Alignment.centerRight),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(7, 7),
                          blurRadius: 20,
                          color: Palheta.Petroleo.withOpacity(0.4))
                    ]),
                child: Container(
                    padding: const EdgeInsets.only(
                        left: 20, top: 25, right: 20, bottom: 24),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "Treino de hoje",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),

                          SizedBox(
                            height: 7,
                          ),

                          Text(
                            "Definição Inferior",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),

                          // SizedBox(height: 25,),
                          Expanded(child: Container()),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    "60 min",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )
                                ],
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                child: Container(
                                  child: Icon(
                                    Icons.play_circle_fill,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColor.neutro0
                                                .withOpacity(0.2),
                                            blurRadius: 10,
                                            offset: Offset(3, 3))
                                      ]),
                                ),
                              )
                            ],
                          )
                        ])),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 180,
                margin: const EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/imgs/backgroundUndraw.png"),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 40,
                                offset: Offset(8, 10),
                                color: Palheta.RoxoLight.withOpacity(0.5))
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 160),
                      height: 160,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.6),
                                Colors.white
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 210,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10, right: 130),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage("assets/imgs/GuyRunning.png"),
                            fit: BoxFit.fitHeight),
                      ),
                    ),
                    Positioned(
                        right: 16,
                        top: 17,
                        //width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Text(
                              "Você está indo\nmuito bem",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Palheta.RoxoMed200),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                  top: 30,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "30 dias",
                                      style: TextStyle(
                                          color: Palheta.Petroleo,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 20,
                                                color: Color.fromARGB(
                                                    186, 255, 106, 65))
                                          ],
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/imgs/fire.png"))),
                                    )
                                  ],
                                ))
                          ],
                        )),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Áreas de foco",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: AppColor.neutro400),
                  )
                ],
              )
            ],
          )),
    );
  }
}
