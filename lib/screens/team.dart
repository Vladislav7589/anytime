import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'item_detail.dart';

class TeamPage extends StatefulWidget {
  @override
  TeamPageState createState() => TeamPageState();
}

class TeamPageState extends State<TeamPage> {
  MenuService menuService = MenuService();


  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/team");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }

  @override
  void initState() {
    menuService.currentPage = Item.team;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [

        Padding(
          padding: EdgeInsets.all(8.0),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Text('Наша команда',
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
                    child: CircularProgressIndicator(color: Color(0xDF290505),),
                  ));
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return  Column(
                children: [
                  Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data["main"].length,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 3/4,
                        maxCrossAxisExtent: 300,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return  Padding(
                            padding: EdgeInsets.all(8),
                            child:  Center(
                              child:  Column(children: [
                                  Expanded(
                                      child: Container(

                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage('http://192.168.0.105:1337${snapshot.data["main"][index]["photo"]["url"]}'),
                                                  fit: BoxFit.contain
                                              ),
                                            ),
                                          ),


                                  ),
                                  Text("${snapshot.data["main"][index]["name"]}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(

                                            color: Color(0xFF575E67),
                                            fontSize: 18.0)),

                                   Text("${snapshot.data["main"][index]["post"]}",
                                        style: const TextStyle(
                                            color: Color(0xDF290505),
                                            fontWeight:  FontWeight.bold,
                                            fontSize: 14.0)),

                                ]),


                            )

                        );  },

                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Лучшие бариста месяца",
                      style: TextStyle(
                          color: Color(0xDF290505),
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold)),
                  Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data["barista"].length,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 3/4,
                        maxCrossAxisExtent: 300,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return  Padding(
                            padding: EdgeInsets.all(8),
                            child:  Center(
                              child:  Column(children: [
                                Expanded(
                                  child: Container(

                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage('http://192.168.0.105:1337${snapshot.data["barista"][index]["photo"]["url"]}'),
                                          fit: BoxFit.contain
                                      ),
                                    ),
                                  ),


                                ),
                                Text("${snapshot.data["barista"][index]["name"]}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0)),

                                Text("${snapshot.data["barista"][index]["post"]}",
                                    style: const TextStyle(
                                        color: Color(0xDF290505),
                                        fontWeight:  FontWeight.bold,
                                        fontSize: 14.0)),

                              ]),


                            )

                        );  },

                    ),
                  )

                ],
              );

            }
          },
        ),
      ]),
    );
  }
} // Or a Dot image


