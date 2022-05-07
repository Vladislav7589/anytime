import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class SchoolPage extends StatelessWidget {
  MenuService menuService = MenuService();


  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/school");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }
  @override
  void initState() {
    menuService.currentPage = Item.school;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [

          Padding(
            padding: EdgeInsets.all(8.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Text('Школа баристы',
                    style: TextStyle(
                        color: Color(0xDF290505),
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          FutureBuilder(
              future: fetchData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${snapshot.data["description"]}:',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18,

                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data["center"].length,
                          itemBuilder: (context, int index) {
                            return  Column(
                              children: [
                                SizedBox(height: 5,),
                                 Container(
                                   color: Colors.black12,
                                   child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(

                                            padding: EdgeInsets.all(8),
                                            child:  Text("${index+1}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 18,

                                                ))),
                                        Expanded(
                                          child: Container(
                                              padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                                              child:   Text("${snapshot.data["center"][index]["title"]}",
                                                    textAlign: TextAlign.justify,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 18,

                                                    )),
                                              ),
                                        ),
                                      ],
                                    ),
                                 ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data["center"][index]["training"].length,
                                    itemBuilder: (context, int ind){
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text('Тренинг «${snapshot.data["center"][index]["training"][ind]["title"]}»:',
                                                    textAlign: TextAlign.justify,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 20,

                                                    )),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text('${snapshot.data["center"][index]["training"][ind]["info"]}',
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,

                                                )),
                                          ),
                                          SizedBox(height: 8,)

                                        ],
                                      );
                                    },),
                                ),

                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        color: Color(0xDFf0eeee),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(

                                "assets/icons/edu.png",
                                height: 70,
                                color: Colors.black,
                              ),
                              Text('${snapshot.data["information"]}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,

                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Image.asset(
                                    "assets/school/school-img-10.jpg",
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(height: 5,),
                                  Text('Участники внутреннего чемпионата Coffee Anytime по латте-арту',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                          fontStyle: FontStyle.italic
                                      )),

                                ],),
                              ),
                              Text('   В январе 2020 и сентябре 2021 прошли совместные чемпионаты сети Coffee Anytime и нашего поставщика свежеобжаренного зерна компании KOF. Наши бариста показывали умение готовить классические напитки, а также уровень своего творчества в приготовлении авторских напитков.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,

                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Image.asset(
                                    "assets/school/school-img-04.jpg",
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(height: 5,),
                                  Text('Участники совместного чемпионата Coffee Anytime и нашего поставщика свежеобжаренного зерна компании KOF. в январе 2020',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic
                                      )),

                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Image.asset(
                                    "assets/school/school-img-05.jpg",
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(height: 5,),
                                  Text('Участники совместного чемпионата Coffee Anytime и нашего поставщика свежеобжаренного зерна компании KOF. в сентябре 2021',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic
                                      )),

                                ],),
                              ),
                              Text('   Помимо крутых мотивационных призов и колоссального опыта, по итогу проведённых чемпионатов мы выберем бариста, которые поедут представлять нашу сеть на региональный Сибирский отборочный чемпионат бариста РЧБ и на Федеральные чемпионаты.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,

                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Image.asset(
                                    "assets/school/school-img-06.jpg",
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(height: 5,),
                                  Text('В Coffee Anytime работают профессиональные, дружные и позитивные бариста',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic
                                      )),

                                ],),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );            }
              }),
        ]),)
    );
  }
}
