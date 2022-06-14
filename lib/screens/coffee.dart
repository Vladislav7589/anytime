import 'dart:convert';

import 'package:any_time/widgets/auth_widget.dart';
import 'package:any_time/widgets/registration_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class CoffeePage extends StatelessWidget {
  MenuService menuService = MenuService();

  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/menu");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }
  @override
  void initState() {
    menuService.currentPage = Item.coffee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Row(
                children: [
                  Text('Наше зерно',
                      style: TextStyle(
                          color: Color(0xDF290505),
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 8,),
              Text("Все кофейные напитки мы готовим из 100% арабики класса Specialty. Каждую неделю – зерно свежей обжарки!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xDF290505),
                    fontSize: 20,

                  )),
              SizedBox(height: 8,),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Наш обжарщик – Даниил Панов\n(компания KOF, г. Новосибирск, ',

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xDF290505),
                          fontSize: 16,

                        )
                    ),
                    WidgetSpan(
                      child: InkWell(
                          child: Text(
                            'www.red-kof.ru',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xDF290505),
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () => launch('https://red-kof.ru/')),
                    ),
                    TextSpan(text: ')',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xDF290505),
                          fontSize: 16,

                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.circle, size: 10, color: Color(0xDF290505),
                    ),),
                  Expanded(
                    child: Text('Сертифицированный Q-grader',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xDF290505),
                          fontSize: 16,
                        )
                    ),
                  ),
                ],),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.circle, size: 10, color: Color(0xDF290505),
                  ),),
                Expanded(
                  child: Text('Многократный призер российских чемпионатов по обжарке кофе',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xDF290505),
                        fontSize: 16,
                      )
                  ),
                ),
              ],),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.circle, size: 10, color: Color(0xDF290505),
                    ),),
                  Expanded(
                    child: Text('Судья чемпионатов бариста',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xDF290505),
                          fontSize: 16,
                        )
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Text("Brazil Eagle",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xDF290505),
                    fontSize: 20,

                  )),
              SizedBox(height: 20,),
                Table(
                defaultVerticalAlignment:
                TableCellVerticalAlignment.middle,
                  columnWidths: Map.from({
                    0: FractionColumnWidth(.55),
                    1: FractionColumnWidth(.45),

                  }),
                border: TableBorder.symmetric(
                    inside: BorderSide(
                        width: 2,
                        color: Color(0xDF290505),
                        style: BorderStyle.solid)),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment : MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(Icons.location_on_outlined,size: 45,color: Color(0xDF290505),),
                          ),
                          Column(
                            crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              Text("Страна: Brazil",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xDF290505),
                                    fontSize: 13,

                                  )),
                              Text("Регион: Mogiana",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xDF290505),
                                    fontSize: 13,

                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                          mainAxisAlignment : MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset(

                              "assets/icons/coffee.png",
                              height: 45,
                              color: Color(0xDF290505),
                            ),
                          ),
                          Column(
                            crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              Text("Обработка:",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xDF290505),
                                    fontSize: 13,

                                  )),
                              Text("натуральная",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xDF290505),
                                    fontSize: 13,

                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment : MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset(

                              "assets/icons/mountain.png",
                              height: 45,
                              color: Color(0xDF290505),
                            ),
                          ),
                          Column(
                            crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              Text("Высота произрастания:",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xDF290505),
                                    fontSize: 13,

                                  )),
                              Text("800–1200 м",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xDF290505),
                                    fontSize: 13,

                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment : MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(Icons.coffee_outlined,size: 45,color: Color(0xDF290505),),
                          ),
                          Column(
                            crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              Text("Вкус чашки:",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xDF290505),
                                    fontSize: 13,

                                  )),
                              Text("орех, шоколад",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xDF290505),
                                    fontSize: 13,

                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
              SizedBox(height: 8,),
              Text("    Brazil Eagle – это собственный бленд компании «Олам» из лучших лотов, производимых в Альта Могиана (Бразилия). Регион расположен между Сан-Паулу и Минас-Джерайс и является местом, где выращиваются наиболее сладкие и хорошо структурированные бразильские лоты.\n     Brazil Eagle обладает очень чистым и мягким вкусом.",
                textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xDF290505),
                    fontSize: 16,

                  )),
             ],
          ),
        ),
      ),
    );
  }
}
