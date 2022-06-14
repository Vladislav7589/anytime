import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
class VacancyPage extends StatefulWidget {
  @override
  VacancyPageState createState() => VacancyPageState();
}

class VacancyPageState extends State<VacancyPage>{

  MenuService menuService = MenuService();
  List<String> imagesList = [
    'assets/vacancy_image/slide_1.jpg',
    'assets/vacancy_image/slide_2.jpg',
    'assets/vacancy_image/slide_3.jpg',
  ];

  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/menu");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }
  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  @override
  void initState() {
    menuService.currentPage = Item.ourProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment : CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: [
                    TextSpan(text: 'WANTED',

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xDF290505),
                          fontSize: 35,

                        )
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.asset(
                          "assets/logo_any.png",
                          height: 35,
                          color: Color(0xDF290505),
                        ),
                      ),
                    ),
                    TextSpan(text: 'BARISTA',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xDF290505),
                          fontSize: 35,

                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Text("В СЕТЬ КОФЕЕН COFFEE ANYTIME ТРЕБУЮТСЯ БАРИСТА",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xDF290505),
                    fontSize: 20,

                  )),
              SizedBox(height: 10,),
              Text("Отдел персонала:",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xDF290505),
                    fontSize: 20,

                  )),
              SizedBox(height: 8,),
              InkWell(
                child: Text(
                  '+7 (3812) 94-89-44',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xDF290505),
                    fontSize: 20,

                  ),
                ),
                onTap: () => launch('tel:+73812948944'),),
              SizedBox(height: 8,),
              InkWell(
                child: Text(
                  '+7 961-880-14-62',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xDF290505),
                    fontSize: 20,

                  ),
                ),
                onTap: () => launch('tel:+79618801462'),
              ),
              SizedBox(height: 15,),
              Text('ТЕБЯ ЖДЁТ',

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xDF290505),
                    fontSize: 30,

                  )
              ),
              Table(
                defaultVerticalAlignment:
                TableCellVerticalAlignment.middle,
                columnWidths: Map.from({
                  0: FractionColumnWidth(.50),
                  1: FractionColumnWidth(.50),

                }),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment : MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.monetization_on_outlined,size: 45,color: Color(0xDF290505),),
                          ),
                          Expanded(
                            child: Text("Достойная заработная плата стабильно два раза в месяц",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xDF290505),
                                  fontSize: 13,

                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment : MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.check,size: 45,color: Color(0xDF290505),),
                          ),
                          Expanded(
                            child: Text("Трудоустройство согласно ТК РФ, полный соц. пакет",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xDF290505),
                                  fontSize: 13,

                                )),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment : MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.wifi_protected_setup,size: 45,color: Color(0xDF290505),),
                          ),
                          Expanded(
                            child: Text("Сменный график работы",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xDF290505),
                                  fontSize: 13,

                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment : MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.cast_for_education,size: 45,color: Color(0xDF290505),),
                          ),
                          Expanded(
                            child: Text("Регулярное обучение, мастер-классы и тренинги",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xDF290505),
                                  fontSize: 13,

                                )),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment : MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.stairs_outlined,size: 45,color: Color(0xDF290505),),
                          ),
                          Expanded(
                            child: Text("Возможность для профессионального и карьерного роста",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xDF290505),
                                  fontSize: 13,

                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment : MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.reduce_capacity,size: 45,color: Color(0xDF290505),),
                          ),
                          Expanded(
                            child: Text("Работа в дружной команде",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xDF290505),
                                  fontSize: 13,

                                )),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),

              CarouselSlider.builder(
                options: CarouselOptions(
                  initialPage: 0,
                  enlargeCenterPage: true,
                  viewportFraction : 1,
                  enableInfiniteScroll: true,
                  pauseAutoPlayOnTouch: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                itemCount: imagesList.length,
                itemBuilder: (BuildContext context, int index,
                    int realIndex) {
                  return  Image.asset(imagesList[index],
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,

                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imagesList.map((urlOfItem) {
                  int index = imagesList.indexOf(urlOfItem);
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color.fromRGBO(0, 0, 0, 0.8)
                          : Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 15,),
              Text("Если заинтерисовало предложение оставьте анкету на сайте:",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xDF290505),
                    fontSize: 20,

                  )),
              InkWell(
                child: Text(
                  'www.coffee-anytime.ru',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xDF290505),
                    fontSize: 20,

                  ),
                ),
                onTap: () => launch('https://job.coffee-anytime.ru/'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
